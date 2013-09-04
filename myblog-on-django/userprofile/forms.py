#forms.py
import re

from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from django.forms import ModelForm
from django.db import models
from userprofile.models import UserProfile
from django.utils.translation import ugettext_lazy as _
from django import forms

class CreateUserForm(UserCreationForm):
    class Meta:
        model = User
        fields = ("username", "email")

class UpdateUserForm(ModelForm):
        
    class Meta:
        model = UserProfile
        fields = ('username', 'email', 'website', 'avatar')

    username = forms.RegexField(
        label=_("Username"), max_length=30, regex=r"^[\w.@+-]+$",
        help_text=_("Required. 30 characters or fewer. Letters, digits and "
                      "@/./+/-/_ only."),
        error_messages={
            'invalid': _("This value may contain only letters, numbers and "
                         "@/./+/-/_ characters.")})
    
    email = forms.EmailField()
    

    def save(self, *args, **kwargs):
        instance = super(UpdateUserForm, self).save(*args, **kwargs)
        user = instance.user
        user.username = self.cleaned_data['username']
        user.email = self.cleaned_data['email']
        user.save()
        return instance


