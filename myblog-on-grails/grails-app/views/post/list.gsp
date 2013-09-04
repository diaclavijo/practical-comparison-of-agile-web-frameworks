
<%@ page import="com.myblog.Post" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'post.label', default: 'Post')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="list-post" class="content scaffold-list" role="main">
			
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			
				
			<g:render template="/blog/post" var="post" collection="${postList}" />
			
			<div class="pagination">
				<g:paginate total="${postTotal}" action="list" params="${params}"/>
			</div>
		</div>
		
		<shiro:authenticated> 
			<h1> Your blog: ${session.user.blog.title }</h1>
			
			<g:render template="/blog/post" var="post" collection="${hisPostList}" />
			
		</shiro:authenticated>
	</body>
</html>
