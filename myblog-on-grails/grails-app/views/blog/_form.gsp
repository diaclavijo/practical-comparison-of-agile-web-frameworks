<%@ page import="com.myblog.Blog" %>


<div class="fieldcontain ${hasErrors(bean: blog, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="blog.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${blog?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: blog, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="blog.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${blog?.title}"/>
</div>


