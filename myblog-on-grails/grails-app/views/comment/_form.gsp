<h2> Create a new comment</h2>

<g:hasErrors bean="${newComment}">
	<ul class="errors" role="alert">
		<g:eachError bean="${newComment}" var="error">
		<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
		</g:eachError>
	</ul>
</g:hasErrors>
<g:form controller="comment" action="save" >
	<g:hiddenField name="post.id" value="${newComment?.post?.id}"/>

	<fieldset class="form">
		<shiro:notAuthenticated> 
			<div class="fieldcontain ${hasErrors(bean: newComment, field: 'username', 'error')} required">
				<label for="username">
					<g:message code="comment.username.label" default="Username" />
					<span class="required-indicator">*</span>
				</label>
				<g:textField name="username" required="" value="${newComment?.username}"/>
			</div>
			
			<div class="fieldcontain ${hasErrors(bean: newComment, field: 'website', 'error')} ">
				<label for="website">
					<g:message code="comment.website.label" default="Website" />
					
				</label>
				<g:textField name="website" value="${newComment?.website}"/>
			</div>
			
			<div class="fieldcontain ${hasErrors(bean: newComment, field: 'email', 'error')} ">
				<label for="email">
					<g:message code="comment.email.label" default="Email" />
					
				</label>
				<g:textField name="email" value="${newComment?.email}"/>
			</div>
		</shiro:notAuthenticated>
		<div class="fieldcontain ${hasErrors(bean: newComment, field: 'body', 'error')} required">
			<label for="body">
				<g:message code="comment.body.label" default="Body" />
				<span class="required-indicator">*</span>
			</label>
			<g:textArea name="body" required="" value="${newComment?.body}"/>
		</div>
		
	
	</fieldset>
	
	<fieldset class="buttons">
		<g:submitButton name="create" class="save" value="Publish comment" />
	</fieldset>

</g:form>

