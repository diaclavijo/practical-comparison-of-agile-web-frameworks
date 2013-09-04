
<g:if test="${comment.user}" >
	<%	comment.username = comment.user.username  
		comment.email = comment.user.email 
	 	comment.website = comment.user.website %>
</g:if>



<p id="username-label" class="property-label"><g:message code="comment.username.label" default="Username" />

${comment.username}</p>





<p id="website-label" class="property-label"><g:message code="comment.website.label" default="Website" />

${comment.website}</p>




<p id="email-label" class="property-label"><g:message code="comment.email.label" default="Email" />

${comment.email}</p>



<p id="body-label" class="property-label"><g:message code="comment.body.label" default="Body" />

${comment.body}</p>

<g:if test="${comment.post.blog.user == com.myblog.AuthUtils.currentUser() }">
	<<g:form>
		<fieldset class="buttons">
			<g:hiddenField name="id" value="${comment.id}" />
			<g:actionSubmit class="delete" controller="comment" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
		</fieldset>
	</g:form>
</g:if>