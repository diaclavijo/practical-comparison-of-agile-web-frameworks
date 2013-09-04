class PostsController < ApplicationController
  before_filter :signed_in_user, :only => [:new, :create, :edit, :update, :destroy, :myindex]
  before_filter :correct_user,   :only => [:edit, :update, :destroy]
  def show
    @post = Post.find_by_permalink(params[:post_permalink])
  end
  def new
    @post = Post.new()
  end
  def index
    @page_count = Post.search(params[:search]).count/3
    @page_count += 1 unless Post.search(params[:search]).count%3 == 0
    @posts = Post.order('created_at DESC').limit(3).offset(params[:offset]).search(params[:search])
    if signed_in?
      @user = User.find(current_user.id)
      render 'posts/signed_user_frontpage'
    else
      render 'posts/index'
    end
  end 
  def user_name_index
    @user = User.find_by_name(params[:user_name])
    @blog = @user.blog
    if @user
      @page_count = @blog.posts.count/3
      @posts = @blog.posts
      render 'index'
    else
      render :inline =>
        "<h1> Error: that user does not exists </h1>"
    end
  end
  def create
    @post = Post.new(params[:post])
    @post.blog_id = current_user.blog.id
    if @post.save
      flash[:success] = "Your post has been published!"
      redirect_to post_path(@post.blog.user.name,@post.permalink)
    else
      render "new"
    end
  end
  def edit
    @post = Post.find_by_permalink(params[:post_permalink])
  end
  def update
    @post = Post.find_by_permalink(params[:post_permalink])
    if @post.update_attributes(params[:post])
      flash[:success] = "Post updated"
      redirect_to post_path(@post.blog.user.name,@post.permalink)
    else
      render 'edit'
    end
  end
  def destroy
    @post = Post.find_by_permalink(params[:post_permalink])
    @post.destroy
    redirect_to :back
  end
  private
    def correct_user
      post = Post.find_by_permalink(params[:post_permalink])
      user = User.find_by_name(params[:user_name])
      unless current_user?(user)
        flash[:notice] = "You are not allowed to do that"
        redirect_to(root_path)
      end
    end
end
