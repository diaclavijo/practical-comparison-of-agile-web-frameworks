class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, :notice => "Please sign in."
      end
    end
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:notice] = "You are not allowed to do that"
        redirect_to(root_path)
      end
    end
end
