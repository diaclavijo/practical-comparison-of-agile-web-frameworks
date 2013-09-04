from django.shortcuts import render
from django.views.generic import ListView
from blog.models import Post
from django.db.models import Q
# Create your views here.
class PostList(ListView):
    paginate_by = 2
    def get_queryset(self):
                
        if 'search' in self.request.GET:
            objects = Post.objects.filter(
                Q(title__icontains=self.request.GET['search']) | Q(body__icontains=self.request.GET['search'])
                )
        else:
            objects = Post.objects.all()
        
        return objects
