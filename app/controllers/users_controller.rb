class UsersController < ApplicationController
  include UsersHelper
  require 'time'
  before_action :is_session_over_no, only: [:new_user, :signup]
  before_action :is_session_over_yes, only: []

=begin
starting pasge of the app , displays login page
=end
  def new_user
  end
=begin
signup page
=end
  def signup
  end
=begin
called when user clicks submit button on login form
=end
  def login
    if check_if_empty(login_params) == true
      flash.now[:error] = "Field cannot be empty"
      render users_new_user_path
      return
    end
    login_status = User.login_using_credentials(login_params)
    if login_status == "wrong username or password"
      flash.now[:error] = "Wrong username or password. Try Again"
      render users_new_user_path
      return
    elsif login_status == "logged in"
      session[:user] = "yes"
      session[:time] = Time.now
      redirect_to urls_new_path
      return
    end
  end
=begin
called when user clicks submit button on signup page
=end
  def signup_entry
    if check_if_empty(signup_params) == true
      flash.now[:error] = "empty field not allowed"
      render users_signup_path
      return
    end
    if User.check_username_available(signup_params) == false
      flash.now[:error] = "Username not available"
      render users_signup_path
      return
    end
    if User.check_email_available(signup_params) == false
      flash.now[:error] = "Email alredy registered"
      render users_signup_path
      return
    end
    if check_password_match(signup_params) == false
      flash.now[:error] = "password dont match"
      render users_signup_path
      return
    end
    User.signup_using_credentials(signup_params)
    redirect_to users_new_user_path
  end

  private
  def login_params
    params.permit(:username, :password)
  end

  def signup_params
    params.permit(:username , :password , :email , :fullname , :confirm_password)
  end
    
end

