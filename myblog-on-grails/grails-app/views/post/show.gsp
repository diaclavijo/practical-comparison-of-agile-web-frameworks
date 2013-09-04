
<%@ page import="com.myblog.Post" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'post.label', default: 'Post')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
				
		<div id="show-post" class="content scaffold-show" role="main">
			
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<g:link controller="post" action="show" id="${post.id}">
				<h1>${post.title}</h2>
			</g:link>
			
			<h3> by 
			<g:link mapping="userblog" params='[username: "${post.blog.user.username }"]'>
			${post.blog.user.username }
			</g:link>
			 . Published on ${post.dateCreated }</h3>
			
			<g:if test="${post.blog.user == com.myblog.AuthUtils.currentUser() }">
				<<g:form>
					<fieldset class="buttons">
						<g:hiddenField name="id" value="${post.id}" />
						<g:link class="edit" controller="post" action="edit" id="${post?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="delete" controller="post" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</g:if>
			
			
			<p>${post.body}</p>
			
			<g:render template="/comment/form" model="[newComment: newComment]"  />
			
			<g:render template="/post/comment" var="comment" collection="${comments}"  /> 

			
		</div>
	</body>
</html>
