<g:link mapping="post" params='[ username: "${post.blog.user.username}" , permalink: "${post.permalink}" ]' >	
	<h2>${post.title}</h2>
	
</g:link>

<h3> by 
<g:link mapping="userblog" params="[username: "${post.blog.user.username}"]" >
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

<small> # ${post.comments?.size() } comments</small>
	




