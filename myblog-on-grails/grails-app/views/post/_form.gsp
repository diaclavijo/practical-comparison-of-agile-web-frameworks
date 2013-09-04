<%@ page import="com.myblog.Post" %>



<div class="fieldcontain ${hasErrors(bean: post, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="post.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${post?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: post, field: 'body', 'error')} required">
	<label for="body">
		<g:message code="post.body.label" default="Body" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="body" required="" value="${post?.body}"/>
</div>



