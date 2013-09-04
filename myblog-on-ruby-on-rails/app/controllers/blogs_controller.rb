class BlogsController < ApplicationController
  before_filter :signed_in_user, :only => [:create, :edit, :update, :destroy]
  # GET /blogs/new
  # GET /blogs/new.json
  def new
    @blog = Blog.new
  end
  # GET /blogs/1/edit
  def edit
    @blog = Blog.find(current_user.blog.id)
  end
  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(params[:blog])
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to @blog, :notice => 'Blog was successfully created.'
    else
      render 'new'
    end
  end
  # PUT /blogs/1
  # PUT /blogs/1.json
  def update
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(params[:blog])
      redirect_to user_posts_path(@blog.user.name), :notice => 'Blog was successfully updated.'
    else
      render :action => "edit"
    end
  end
  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_url
  end
end
