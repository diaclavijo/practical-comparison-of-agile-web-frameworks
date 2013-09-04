from django.template.base import Library

register = Library()

@register.inclusion_tag('blog/post.html', takes_context=True)
def show_post(context, post):
    return { 'post' : post ,
              'user' : context['user'] }
