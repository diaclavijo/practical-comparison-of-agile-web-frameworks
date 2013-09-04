from django.db import models
from django.contrib.auth.models import User
from django.core.urlresolvers import reverse
from django.template.defaultfilters import slugify

from django.dispatch import receiver
from django.db.models.signals import pre_delete
# Create your models here.
class Blog(models.Model):
    user = models.OneToOneField(User, editable=False)
    title = models.CharField(max_length=100)
    description = models.TextField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add = True)

    def get_absolute_url(self):
        return reverse('blog', kwargs={'slug': self.user.username})

class Post(models.Model):
 
    blog = models.ForeignKey(Blog, editable=False)
    title = models.CharField(max_length=100)
    slug = models.CharField(max_length=200, editable=False, unique=True)
    body = models.TextField()
    created_at = models.DateTimeField(auto_now_add = True)
    
    def get_absolute_url(self):
        return reverse('post',
                        kwargs={'username': self.blog.user.username,
                                'slug': self.slug})
    def save(self):
        if not self.id:
            self.slug = slugify(self.title)
        return super(Post, self).save()

    class Meta:
        ordering = ["-created_at"]
        
class Comment(models.Model):
    post = models.ForeignKey(Post, editable=False)
    
    user = models.CharField(max_length=100)
    website = models.CharField(max_length=100, null=True, blank=True)
    email = models.EmailField()
    body = models.TextField()

    reg_user = models.ForeignKey(User,
                            editable=False,
                            blank=True,
                            null=True,
                            on_delete=models.SET_NULL)

    created_at = models.DateTimeField(auto_now_add = True)

    class Meta:
        ordering = ["-created_at"]

    # Signal for pre delete user and update comments
    @receiver(pre_delete, sender=User)
    def delete_user_handler(sender, instance, **kwargs):
        
        for comment in instance.comment_set.all():
            comment.user = instance.username
            comment.email = instance.email
            comment.website = instance.userprofile.website



