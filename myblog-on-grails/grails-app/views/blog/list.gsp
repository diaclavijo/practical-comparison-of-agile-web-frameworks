
<%@ page import="com.myblog.Blog" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'blog.label', default: 'Blog')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-blog" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-blog" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					

						<g:sortableColumn property="description" title="${message(code: 'blog.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="title" title="${message(code: 'blog.title.label', default: 'Title')}" />
					
						<th><g:message code="blog.user.label" default="User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${blogList}" status="i" var="blog">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${blog.id}"> ${fieldValue(bean: blog, field: "description")} </g:link></td>
					
						<td>${fieldValue(bean: blog, field: "title")}</td>
					
						<td>${fieldValue(bean: blog, field: "user")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${blogTotal}" />
			</div>
		</div>
	</body>
</html>
