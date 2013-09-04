<%@ page import="com.myblog.Comment" %>



<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="comment.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" value="${commentInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'website', 'error')} ">
	<label for="website">
		<g:message code="comment.website.label" default="Website" />
		
	</label>
	<g:textField name="website" value="${commentInstance?.website}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'email', 'error')} ">
	<label for="email">
		<g:message code="comment.email.label" default="Email" />
		
	</label>
	<g:textField name="email" value="${commentInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'body', 'error')} required">
	<label for="body">
		<g:message code="comment.body.label" default="Body" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="body" required="" value="${commentInstance?.body}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'post', 'error')} required">
	<label for="post">
		<g:message code="comment.post.label" default="Post" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="post" name="post.id" from="${com.myblog.Post.list()}" optionKey="id" required="" value="${commentInstance?.post?.id}" class="many-to-one"/>
</div>

