
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
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="title" title="${message(code: 'post.title.label', default: 'Title')}" />
					
						<g:sortableColumn property="body" title="${message(code: 'post.body.label', default: 'Body')}" />
					
						<th><g:message code="post.blog.label" default="Blog" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'post.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'post.lastUpdated.label', default: 'Last Updated')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${postList}" status="i" var="post">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${post.id}">${fieldValue(bean: post, field: "title")}</g:link></td>
					
						<td>${fieldValue(bean: post, field: "body")}</td>
					
						<td>${fieldValue(bean: post, field: "blog")}</td>
					
						<td><g:formatDate date="${post.dateCreated}" /></td>
					
						<td><g:formatDate date="${post.lastUpdated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${postTotal}" />
			</div>
		</div>
	</body>
</html>
