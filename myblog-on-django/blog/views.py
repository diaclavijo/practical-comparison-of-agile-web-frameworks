from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.core.urlresolvers import reverse, reverse_lazy

from blog.models import Blog, Post, Comment
from django.contrib.auth.models import User
from django.views.generic.edit import CreateView, UpdateView, DeleteView
from django.views.generic.detail import DetailView
from django.views.generic.edit import FormMixin

from django.contrib import messages

from django.core.exceptions import PermissionDenied

from django.forms import models as model_forms

from blog.forms import RegisteredUserCreateCommentForm
# Create your views here.
class BlogDetail(DetailView):
    template_name = 'blog/blog.html'
    context_object_name = 'blog'
        
    def dispatch(self, *args, **kwargs):
        return super(DetailView, self).dispatch(*args, **kwargs)

    def get_object(self):
        """
        Returns the user's blog
        """
        
        slug = self.kwargs.get(self.slug_url_kwarg, None)
        return User.objects.get(username=slug).blog

class BlogCreate(CreateView):
       
    model = Blog

    base_template = 'base.html'

    def get_context_data(self, **kwargs):
        kwargs['base_template'] = self.base_template
        return super(BlogCreate, self).get_context_data(**kwargs)
    
    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(BlogCreate, self).dispatch(*args, **kwargs)
        
    def form_valid(self, form):
        """
        This method is called when valid form data has been POSTed.
        The blog has to be linked to the user
        """
        
        form.instance.user = self.request.user
            
        return super(CreateView, self).form_valid(form)

class BlogUpdate(UpdateView):
    base_template = 'base_settings.html'
    success_url = reverse_lazy('blog_update')

    def get_context_data(self, **kwargs):
        kwargs['base_template'] = self.base_template
        return super(BlogUpdate, self).get_context_data(**kwargs)
        
    def get_object(self):
        """
        Returns the current user blog
        """
        return self.request.user.blog

    def form_valid(self, form):
        """
        Introduces the message
        """
        messages.success(self.request, "Your blog has been successfully updated")
        return super(BlogUpdate, self).form_valid(form)

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(BlogUpdate, self).dispatch(*args, **kwargs)

class BlogDelete(DeleteView):
    success_url = '/'
       
    def get_object(self):
        return self.request.user.blog

    def delete(self, request, *args, **kwargs):
        """
        Insert the message and call the super method
        """
        messages.success(self.request, "Your blog has been sucessfully deleted")
        return super(BlogDelete, self).delete(request, *args, **kwargs)

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(BlogDelete, self).dispatch(*args, **kwargs)

class PostDetail(DetailView, FormMixin):
    """
    Post view with a form to comment on a post
    """
    model = Post
    form_class = model_forms.modelform_factory(Comment)

    def get_form_class(self):
        """
        Returns the form class to use in this view
        """
        if self.request.user.is_authenticated():
            return RegisteredUserCreateCommentForm
        else:
            return self.form_class

    def get_success_url(self):
        return reverse('post',
                        kwargs={'username': self.object.blog.user.username,
                                'slug': self.object.slug})

    def get_context_data(self, **kwargs):
        context = super(PostDetail, self).get_context_data(**kwargs)
        form_class = self.get_form_class()
        context['form'] = self.get_form(form_class)
        return context  

    def post(self, request, *args, **kwargs):
        self.object = self.get_object()
        form_class = self.get_form_class()
        form = self.get_form(form_class)
        if form.is_valid():
            return self.form_valid(form)
        else:
            return self.form_invalid(form)

    def form_valid(self, form):
        """
        Relates the comment with the post. 
        """
        form.instance.post = self.object
        
        if self.request.user.is_authenticated():
            form.instance.user = self.request.user.username
            form.instance.website = self.request.user.userprofile.website
            form.instance.email = self.request.user.email
            form.instance.reg_user = self.request.user

        form.save()
        
        messages.success(self.request, "Your comment has been sucessfully created")

        return super(PostDetail, self).form_valid(form)
    
    def get_object(self):
        """
        Returns the post asked
        """
        slug = self.kwargs.get(self.slug_url_kwarg, None)
        username = self.kwargs.get('username', None)
       
        return User.objects.get(username=username).blog.post_set.get(slug=slug)

class PostCreate(CreateView):
    model = Post
        
    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(PostCreate, self).dispatch(*args, **kwargs)

    def form_valid(self, form):
        """
        This method is called when valid form data has been POSTed.
        The post has to be linked to the user's blog
        """
        
        form.instance.blog = self.request.user.blog
            
        return super(PostCreate, self).form_valid(form)

class PostUpdate(UpdateView):
    
    def get_object(self):
        """
        Returns the user's post if the user is the owner
        """
        slug = self.kwargs.get(self.slug_url_kwarg, None)
        username = self.kwargs.get('username', None)

        user = User.objects.get(username=username)
       
        if user == self.request.user:
            return User.objects.get(username=username).blog.post_set.get(slug=slug)
        else:
            raise PermissionDenied
    
    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(PostUpdate, self).dispatch(*args, **kwargs)

class PostDelete(DeleteView):
    success_url = '/'
       
    def get_object(self):
        """
        Return the user's post if the user is the owner. This is Code
        reptition. It is the same in PostUpdate, consider refactoring.
        """
        slug = self.kwargs.get(self.slug_url_kwarg, None)
        username = self.kwargs.get('username', None)

        user = User.objects.get(username=username)
       
        if user == self.request.user:
            return User.objects.get(username=username).blog.post_set.get(slug=slug)
        else:
            raise PermissionDenied
    
    def delete(self, request, *args, **kwargs):
        """
        Insert the message and call the super method
        """
        messages.success(self.request, "Your post has been sucessfully deleted")
        return super(PostDelete, self).delete(request, *args, **kwargs)

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(PostDelete, self).dispatch(*args, **kwargs)

class CommentDelete(DeleteView):

    def get_object(self):
        """
        Return the user's post if the user is the owner. This is Code
        reptition. It is the same in PostUpdate, consider refactoring.
        """
        slug = self.kwargs.get(self.slug_url_kwarg, None)
        username = self.kwargs.get('username', None)
        pk = self.kwargs.get('pk', None)
        
        user = User.objects.get(username=username)
       
        if user == self.request.user:
            return User.objects.get(username=username).blog.post_set.get(slug=slug).comment_set.get(pk=pk)
        else:
            raise PermissionDenied

    def delete(self, request, *args, **kwargs):
        """
        Insert the message and call the super method
        """
        messages.success(self.request, "The comment has been sucessfully deleted")
        return super(CommentDelete, self).delete(request, *args, **kwargs)
    
    def get_success_url(self):
        return reverse('post',
                        kwargs={'username': self.object.post.blog.user.username,
                                'slug': self.object.post.slug})

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(CommentDelete, self).dispatch(*args, **kwargs)
