from django.forms import ModelForm
from blog.models import Comment
class RegisteredUserCreateCommentForm(ModelForm):
        
    class Meta:
        model = Comment
        fields = ('body',)
