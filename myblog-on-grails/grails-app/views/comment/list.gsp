
<%@ page import="com.myblog.Comment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'comment.label', default: 'Comment')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-comment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-comment" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="username" title="${message(code: 'comment.username.label', default: 'Username')}" />
					
						<g:sortableColumn property="website" title="${message(code: 'comment.website.label', default: 'Website')}" />
					
						<g:sortableColumn property="email" title="${message(code: 'comment.email.label', default: 'Email')}" />
					
						<g:sortableColumn property="body" title="${message(code: 'comment.body.label', default: 'Body')}" />
					
						<th><g:message code="comment.post.label" default="Post" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${commentInstanceList}" status="i" var="commentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${commentInstance.id}">${fieldValue(bean: commentInstance, field: "username")}</g:link></td>
					
						<td>${fieldValue(bean: commentInstance, field: "website")}</td>
					
						<td>${fieldValue(bean: commentInstance, field: "email")}</td>
					
						<td>${fieldValue(bean: commentInstance, field: "body")}</td>
					
						<td>${fieldValue(bean: commentInstance, field: "post")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${commentInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
