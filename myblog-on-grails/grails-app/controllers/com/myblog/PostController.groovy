package com.myblog

import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils

@Mixin(AuthUtils)
class PostController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
		def postList
		def postTotal
		def hisPostList
		hisPostList=[]
        params.max = Math.min(max ?: 3, 6)

		if ( params.searchquery == null) {
			postList = Post.list(params)
			postTotal = Post.count()
		}
		else{
			postList = Post.findAllByTitleLikeOrBodyLike('%'+params.searchquery+'%','%'+params.searchquery+'%',params)
			postTotal = Post.findAllByTitleLikeOrBodyLike('%'+params.searchquery+'%','%'+params.searchquery+'%').size()
		}

		if (SecurityUtils.subject.authenticated){
			def user = currentUser()
			hisPostList = user.blog.posts
		}
		
		[postList: postList, postTotal: postTotal, params: params, hisPostList: hisPostList ]
    }

    def create() {
		
        [post: new Post(params)]
    }

    def save() {
        def post = new Post(params)
		post.blog = currentUser().blog
        if (!post.save(flush: true)) {
            render(view: "create", model: [post: post])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'post.label', default: 'Post'), post.id])
        redirect(mapping: "post", params: [username: post.blog.user.username, permalink: post.permalink])
    }

    def show() {
		
        def post = Post.findByPermalink(params.permalink)
        if (!post) {
            flash.message = "Post not found"
            redirect(action: "list")
            return
        }
		def newComment = new Comment()
		newComment.post = post
        [post: post, newComment: newComment, comments: post.comments]
    }

    def edit(Long id) {
        def post = Post.get(id)
        if (!post) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'post.label', default: 'Post'), id])
            redirect(action: "list")
            return
        }

        [post: post]
    }

    def update(Long id, Long version) {
        def post = Post.get(id)
        if (!post) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'post.label', default: 'Post'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (post.version > version) {
                post.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'post.label', default: 'Post')] as Object[],
                          "Another user has updated this Post while you were editing")
                render(view: "edit", model: [post: post])
                return
            }
        }

        post.properties = params

        if (!post.save(flush: true)) {
            render(view: "edit", model: [post: post])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'post.label', default: 'Post'), post.id])
        redirect(action: "show", id: post.id)
    }

    def delete(Long id) {
        def post = Post.get(id)
        if (!post) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'post.label', default: 'Post'), id])
            redirect(action: "list")
            return
        }

        try {
            post.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'post.label', default: 'Post'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'post.label', default: 'Post'), id])
            redirect(action: "show", id: id)
        }
    }
}
