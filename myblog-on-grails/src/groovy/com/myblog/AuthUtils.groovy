package com.myblog

import org.apache.shiro.SecurityUtils
import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.web.util.SavedRequest
import org.apache.shiro.web.util.WebUtils
import org.apache.shiro.grails.ConfigUtils

@Category(Object)
class AuthUtils {
	def shiroSecurityManager
	def login(username, password, rememberMe){
		def authToken = new UsernamePasswordToken(params.username, params.password as String)
		
		// Support for "remember me"
		if (rememberMe) {
			authToken.rememberMe = true
		}
				
		try{
			// Perform the actual login. An AuthenticationException
			// will be thrown if the username is unrecognised or the
			// password is incorrect.
			SecurityUtils.subject.login(authToken)
			
			return true
		}
		catch (AuthenticationException ex){
			// Authentication failed, so display the appropriate message
			// on the login page.
			return false 
	
		}
	}
	
	def currentUser(){
		User.findByUsername(SecurityUtils.subject.getPrincipal())
	}
	
	def insertDataSession(){
		def user = User.findByUsername(SecurityUtils.subject.getPrincipal())
		
		session.user = [:]
		session.user.put("username",SecurityUtils.subject.getPrincipal() )
		session.user.put("blog",user.blog )
		
	}
	
	
}

