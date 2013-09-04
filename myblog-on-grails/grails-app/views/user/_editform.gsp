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


<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'website', 'error')}">
	<label for="website">
		<g:message code="user.website.label" default="Website" />
	</label>
	<g:field type="website" name="website" required="" value="${userInstance?.website}"/>
</div>

<fieldset>
  <legend>Avatar Upload</legend>
 
    <label for="avatar">Avatar</label>
    <input type="file" name="avatar" id="avatar" />
   
</fieldset>
