from django.db import models
from django.contrib.auth.models import User

User._meta.get_field('email')._unique = True #to get uniqueness in email. This is evil, if you know how to solve in other way, change this. 

# Create your models here.
class UserProfile(models.Model):
    user = models.OneToOneField(User)
    website = models.CharField(max_length=100,blank=True)

    # image =  TO DO
    avatar = models.ImageField(upload_to='avatars', null=True, blank=True)

    
