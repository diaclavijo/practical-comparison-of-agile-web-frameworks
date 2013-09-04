from django.views.generic import DetailView
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.views.generic.edit import CreateView, UpdateView, DeleteView
from userprofile.models import UserProfile
from django.core.urlresolvers import reverse_lazy
from userprofile.forms import UpdateUserForm, CreateUserForm
from django.contrib.auth import authenticate, login
from django.contrib import messages
from django.contrib.auth.forms import PasswordChangeForm
from django.core.urlresolvers import reverse_lazy
from django.views.generic import FormView

from blog.models import Blog

class UserDetail(DetailView):
    model = UserProfile
    template_name = 'userprofile/user.html'

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(UserDetail, self).dispatch(*args, **kwargs)
    
    def get_object(self):
        return self.request.user

class UserCreate(CreateView):
    template_name = 'userprofile/user_form.html'
    form_class = CreateUserForm
    model = User

    success_url = '/'

    def form_valid(self, form):
        """
        This method is called when valid form data has been POSTed.
        The user must be logged once it has been created. 
        """
        
        myresponse = super(CreateView, self).form_valid(form)
        
        username = self.request.POST['username']
        password = self.request.POST['password1']
        
        user = authenticate(username=username, password=password)

        if user is not None:
            login(self.request, user)
            user.userprofile = UserProfile(website='')
            user.userprofile.save()
        else:
            raise Exception('User is not registered')
            
        return myresponse


class UserUpdate(UpdateView):
    model = UserProfile
    template_name = 'userprofile/update.html'
    form_class = UpdateUserForm
    success_url = '/user/settings'
    
    def get_initial(self):
        return {'username': self.request.user.username, 'email': self.request.user.email}
        
    def get_object(self):
        """
        Returns the current user
        """
        return self.request.user.userprofile

    def form_valid(self, form):
        """
        Introduces the message
        """
        messages.success(self.request, "Your user has been successfully updated")
        return super(UpdateView, self).form_valid(form)

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(UserUpdate, self).dispatch(*args, **kwargs)

class UserDelete(DeleteView):
    model = User
    success_url = '/'
    template_name= 'userprofile/user_confirm_delete.html'
    
    def get_object(self):
        return self.request.user

    def delete(self, request, *args, **kwargs):
        """
        Insert the message and call the super method
        """
        messages.success(self.request, "Your user has been sucessfully deleted")
        return super(DeleteView, self).delete(request, *args, **kwargs)

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(UserDelete, self).dispatch(*args, **kwargs)


class PasswordChangeView(FormView):
    template_name = 'registration/password_change_form.html'
    form_class = PasswordChangeForm
    success_url = reverse_lazy('settings')

    def get_form_kwargs(self):
        kwargs = super(PasswordChangeView, self).get_form_kwargs()
        kwargs['user'] = self.request.user
        return kwargs

    def form_valid(self, form):
        form.save()
        messages.success(self.request, "Your password has been changed.")
        return super(FormView, self).form_valid(form)

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(PasswordChangeView, self).dispatch(*args, **kwargs)
    
