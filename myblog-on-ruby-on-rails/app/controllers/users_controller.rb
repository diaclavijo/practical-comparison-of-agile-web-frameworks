class UsersController < ApplicationController
  before_filter :signed_in_user, :only => [:edit, :update, :destroy, :update_password, :new_password]
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
    @user.check_password = true
    if @user.save
      sign_in @user
      flash[:success] = "Now you can create your blog!"
      @blog = @user.build_blog
      render 'blogs/new'
    else
      render "new"
    end
  end
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end 
  end
  def update_password
    @user = User.find(current_user.id)
    if @user.authenticate(params[:current_password])
      @user.check_password = true
      puts params[:user].to_s
      if @user.update_attributes(params[:user])
        sign_in @user
        flash.now[:success] = "Password changed"
        render 'show'
      else
        render 'new_password'
      end
    else
      flash[:error] = "Wrong password"
      render 'new_password'
    end
  end
  def new_password
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(current_user.id)
  end
  def destroy
    @user = User.find(current_user.id)
    #sets all comments information
    @user.comments.each{|comment|
      comment.author = @user.name
      comment.website = @user.website
      comment.email = @user.email
      comment.save
      }
    #end set all comments information
    @user.destroy
    redirect_to root_path, :notice => 'Your account has been successfully removed'
  end
end
