
<%@ page import="com.myblog.Blog" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'blog.label', default: 'Blog')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		
		<div id="show-blog" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<h1> ${blog?.title }</h1>
		
			<p> ${blog?.description} </p>
			
		
			<g:if test="${blog.posts==null}">
				You haven't wrote any post, why don't you write one ?
					<g:link controller="post" action="create" > 
						Write a post!				
					</g:link>
			</g:if>
			
			<g:render template="post" var="post" collection="${posts}" />
			
			<g:if test="${blog.user == com.myblog.AuthUtils.currentUser() }">
				<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="${blog?.id}" />
						<g:link class="edit" action="edit" id="${blog?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</g:if>
		
			<div class="pagination">
				<g:paginate total="${postsTotal}" controller="blog" action="show" params="${params}"/>
			</div>
		
		</div>
	</body>
</html>
