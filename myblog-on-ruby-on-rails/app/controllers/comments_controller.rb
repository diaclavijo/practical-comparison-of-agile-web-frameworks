class CommentsController < ApplicationController
  before_filter :signed_in_user, :only => [:destroy]
  before_filter :correct_user,   :only => [:destroy]
  # POST /comments
  def create
    @post = Post.find_by_permalink(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    if params[:user] && params[:user][:user_id]
      if current_user?(User.find(params[:user][:user_id]))
        @comment.user_id = params[:user][:user_id]
        @comment.author = 'registereduser'
        @comment.email = 'registereduser@email.com'
        @comment.website = 'registereduser'
      else
        redirect_to post_path(@post.blog.user.name,@post.permalink), :error => 'You are not a register user' 
      end
    end
    if @comment.save
      redirect_to post_path(@post.blog.user.name,@post.permalink), :notice => 'Comment was successfully created.' 
    else
      @post.comments.pop
      render 'posts/show'
    end
  end
  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back, :notice => 'Comment was succesfully removed'
  end
  private
    def correct_user
      comment = Comment.find(params[:id])
      user = User.find(comment.post.blog.user.id)
      unless current_user?(user)
        flash[:notice] = "You are not allowed to do that"
        redirect_to(root_path)
      end
    end
end
