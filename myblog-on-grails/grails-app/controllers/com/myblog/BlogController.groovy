package com.myblog

import org.springframework.dao.DataIntegrityViolationException

@Mixin(AuthUtils)
class BlogController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [blogList: Blog.list(params), blogTotal: Blog.count()]
    }

    def create() {
        [blog: new Blog(params)]
    }

    def save() {
        def blog = new Blog(params)
			
		blog.user = currentUser()
		
		if (blog.save()) {
			session.user.blog = blog
			flash.message = 'Succesfully created'
			redirect(mapping: 'userblog', params: [username: blog.user.username])
			
		}else{
			flash.message = 'Something went wrong'
			render(view: "create", model: [blog: blog])
		}
		
    }

    def show(Integer max) {
		params.max = Math.min(max ?: 1, 1)
		
		def user = User.findByUsername(params.username)
        def blog = Blog.findByUser(user)
		def posts = Post.findAllByBlog(blog,params)
		def postsTotal = Post.findAllByBlog(blog).size()
		
		
		
        if (!blog) {
            flash.message = "user not found"
            redirect(action: "list")
            return
        }
		
	
        [blog: blog, posts: posts, postsTotal: postsTotal, params: params]
    }

    def edit() {
        def blog = Blog.findByUser(currentUser())
		
		
		
        if (!blog) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'blog.label', default: 'Blog'), id])
            redirect(action: "list")
            return
        }

        [blog: blog]
    }

    def update(Long id, Long version) {
        def blog = Blog.findByUser(currentUser())
		
        if (!blog) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'blog.label', default: 'Blog'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (blog.version > version) {
                blog.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'blog.label', default: 'Blog')] as Object[],
                          "Another user has updated this Blog while you were editing")
                render(view: "edit", model: [blog: blog])
                return
            }
        }

        blog.properties = params

        if (!blog.save(flush: true)) {
            render(view: "edit", model: [blog: blog])
            return
        }

        flash.message = "Blog succesfully edited" 
        redirect(mapping: "userblog", params: [username: blog.user.username])
    }

    def delete() {
        def user = currentUser()
	    def blog = user.blog
		
	    user.blog = null 
	    user.save()
	   
        try {
			blog.delete()
            flash.message = "Succesfully deleted "
			session.user.blog = null 
            return

        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'blog.label', default: 'Blog'), id])
            redirect(action: "show", id: id)
        }
    }
}
