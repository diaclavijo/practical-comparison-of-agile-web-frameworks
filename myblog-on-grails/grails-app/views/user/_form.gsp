<%@ page import="com.myblog.User" %>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" value="${userInstance?.username}"/>
</div>


<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="user.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" required="" value="${userInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" />
</div>


<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'passwordConfirmation', 'error')} required">
	<label for="password">
		<g:message code="user.passwordConfirmation.label" default="Password confirmation" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="passwordConfirmation" required="" />
</div>
