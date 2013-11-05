package com.myblog

import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils

@Mixin(AuthUtils)
class CommentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def save() {
		if (SecurityUtils.subject.authenticated){
			def user = User.findByUsername(SecurityUtils.subject.getPrincipal())
			params.username = user.username
			params.email = user.email
			params.website = user.website 
			params["user.id"] = user.id
			
		}
		
		def newComment = new Comment(params)
		
        if (!newComment.save(flush: true)) {
            render(view: "/post/show", model:  [post: newComment.post, newComment: newComment, comments:newComment.post.comments])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'comment.label', default: 'Comment'), newComment.id])
        redirect(mapping: 'post', params: [username: newComment.post.blog.user.username, permalink: newComment.post.permalink])

    }

    def delete(Long id) {
        def comment = Comment.get(id)
		
        if (!comment) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), id])
            redirect(action: "list")
            return
        }
		
		if (comment.post.blog.user != currentUser()){
			 render ("You are not allowed to do that")
			 return	
		}

        try {
            comment.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'comment.label', default: 'Comment'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'comment.label', default: 'Comment'), id])
            redirect(action: "show", id: id)
        }
    }
}
