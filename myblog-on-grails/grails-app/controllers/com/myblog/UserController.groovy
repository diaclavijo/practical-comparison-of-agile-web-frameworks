package com.myblog

import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.SecurityUtils


@Mixin(AuthUtils)
class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	def shiroSecurityService
	
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
		
        params.max = Math.min(max ?: 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }

    def create() {
        [userInstance: new User(params)]
		
    }

    def save(PasswordValidation passwordValidation) {
		
		
		//encryption
		params.passwordHash = shiroSecurityService.encodePassword(params.password)
		//end encryption
		def password = params.remove("password")
		params.remove("passwordConfirmation")
		
		def userInstance = new User(params)
		
        if ( userInstance.validate()  && (!passwordValidation.hasErrors()) && userInstance.save(flush: true) ) {
			//give the user role
			def userRole = Role.findByName('USER')
			userInstance.addToRoles(userRole).save(flush: true, failOnError: true)
			
			//login
			def authToken = new UsernamePasswordToken(params.username, password as String)
			SecurityUtils.subject.login(authToken)
			
			//Introduce user data in the session
			session.user = [:]
			session.user.put("username",SecurityUtils.subject.getPrincipal() )
			
			flash.message = "User succesfully created, you can now create your blog"
			redirect(controller: "blog", action: "create")
        }

		render(view: "create", model: [userInstance: userInstance, passwordValidation: passwordValidation])
		return        
    }

    def show() {
        def userInstance = User.findByUsername(SecurityUtils.getSubject().getPrincipal())
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def edit(Long id) {
        def userInstance = User.findByUsername(session.user.username)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def update(Long version) {
        def userInstance = User.findByUsername( SecurityUtils.getSubject().getPrincipal() )
		
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'user.label', default: 'User')] as Object[],
                          "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }
		
		if (!params.avatar.isEmpty()){
			println 'i entered here '
			// Get the avatar file from the multi-part request
			def f = request.getFile('avatar')
			
			def okcontents = ['image/png', 'image/jpeg', 'image/gif']
			if (! okcontents.contains(f.getContentType())) {
			  flash.message = "Avatar must be one of: ${okcontents}"
			  render(view:'edit', model:[userInstance:userInstance])
			  return;
			}
			
			// Save the image and mime type
			userInstance.avatar = f.getBytes()
			userInstance.avatarType = f.getContentType()
		}else{
			params.avatar = null
			params.avatarType = null
		}
		
        userInstance.properties = params
		
		println 'user instance'
		println userInstance


        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def delete() {
		def user = currentUser()
		SecurityUtils.subject?.logout()

		try {
			user.delete(flush:true)
			flash.message = 'User succesfully removed'
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
			redirect(action: "show", id: id)
		}
		
    }
	
	
	
	def newPassword(){	}
	
	def changePassword(PasswordValidation passwordValidation){
		def userInstance = User.findByUsername(session.user.username)
		
		if (!userInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
			redirect(action: "list")
			return
		}
		def currentPasswordHash = shiroSecurityService.encodePassword(params.currentPassword)
		if ( (currentPasswordHash == userInstance.passwordHash) && (! passwordValidation.hasErrors() )){
			
			//encryption
			params.passwordHash = shiroSecurityService.encodePassword(params.password)
			//end encryption
			def password = params.remove("password")
			params.remove("passwordConfirmation")
			
			userInstance.properties = params
			
			if (!userInstance.save(flush: true)) {
				render(view: "edit", model: [userInstance: userInstance])
				return
			}
			
			//login
			def authToken = new UsernamePasswordToken(session.user.username, password as String)
			SecurityUtils.subject.login(authToken)
	
			flash.message = "Password has changed successfully"
			redirect(action: "show")
			
		}else{
			flash.now.message = "Invalid current password" 
		}
		
		render(view: "newPassword", model: [passwordValidation: passwordValidation])

	}
	
	
	def avatar_image = {
		def avatarUser = User.get(params.id)
		if (!avatarUser || !avatarUser.avatar || !avatarUser.avatarType) {
		  response.sendError(404)
		  return;
		}
		response.setContentType(avatarUser.avatarType)
		response.setContentLength(avatarUser.avatar.size())
		OutputStream out = response.getOutputStream();
		out.write(avatarUser.avatar);
		out.close();
	  }
}


class PasswordValidation {
	String password
	String passwordConfirmation

	static constraints = {
		password(blank: false, nullable: false, size:1..20, validator: {password, obj ->
				def passwordConfirmation = obj.properties['passwordConfirmation']
				passwordConfirmation == password ? true : ['invalid.matchingpasswords']
			}
		)
	}
}
