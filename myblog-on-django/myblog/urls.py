from django.conf.urls import patterns, include, url
from userprofile.views import UserDetail, UserCreate, UserUpdate, UserDelete, PasswordChangeView
from django.conf.urls.static import static
from django.conf import settings
from django.contrib.auth import views
from blog.views import BlogCreate, BlogDetail, BlogUpdate, BlogDelete, PostDetail, PostCreate, PostDelete, PostUpdate, CommentDelete
from myblog.views import PostList
# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    url(r'^$', PostList.as_view(), name='home'),
    url(r'^login$','django.contrib.auth.views.login', name='login'),
    url(r'^logout$','django.contrib.auth.views.logout', {'next_page' : '/'} , name='logout')  ,
    url(r'^user/settings$',UserUpdate.as_view(), name='settings'),
    url(r'^user/signup/$', UserCreate.as_view(), name='signup'),
    url(r'^user/delete/$', UserDelete.as_view(), name='user_delete') ,
    url(r'^user/password-change/$', PasswordChangeView.as_view(), name='user_pass_change') ,

    url(r'^user/createblog$', BlogCreate.as_view(), name='blog_create') ,
    # the next ilne has an error, it regexp has to be tested against possible values for the username
    
    url(r'^user/settings/blog$', BlogUpdate.as_view(), name='blog_update') ,
    url(r'^user/settings/blog/delete$', BlogDelete.as_view(), name='blog_delete') ,
    
    url(r'^user/post$', PostCreate.as_view(), name='post_create') ,

    url(r'^(?P<slug>[-_\w]+)/$', BlogDetail.as_view(), name='blog') ,
    
    url(r'^(?P<username>[-_\w]+)/(?P<slug>[-_\w]+)$', PostDetail.as_view(), name='post') ,
    url(r'^(?P<username>[-_\w]+)/(?P<slug>[-_\w]+)/comment/(?P<pk>\d+)/delete$', CommentDelete.as_view(), name='comment_delete') ,
    url(r'^(?P<username>[-_\w]+)/(?P<slug>[-_\w]+)/edit$', PostUpdate.as_view(), name='post_update') ,
    url(r'^(?P<username>[-_\w]+)/(?P<slug>[-_\w]+)/delete$', PostDelete.as_view(), name='post_delete') ,
    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^admin/', include(admin.site.urls)),
) + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
