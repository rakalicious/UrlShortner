class UsersController < ApplicationController
	include UsersHelper
	require 'time'

=begin
starting pasge of the app , displays login page
=end
	def new_user
		if is_session_over_no == true
			redirect_to urls_new_path
			return
		end
		flash[:error] = ""
	end
=begin
signup page
=end
	def signup
		if is_session_over_no == true
			redirect_to urls_new_path
			return
		end
		flash[:error] = ""
	end
=begin
called when user clicks submit button on login form
=end
	def login
		#checks if any field is empty
		if check_if_empty(params[:username] , params[:password]) == true
			flash[:error] = "Field cannot be empty"
  			render users_new_user_path
			return
		end
		login_status = User.try_login(login_params)
		#login_status = User.try_login(params[:username],params[:password])
		#3 conditions 
		#1 - wrong username
		if login_status == "wrong username"
			flash[:error] = "Wrong username. Try Again"
  			render users_new_user_path
			return
		#2 - wrong password
		elsif login_status == "wrong password"
			flash[:error] = "Wrong password. Try Again"
  			render users_new_user_path
			return
		#3 - logged in succesfully
		elsif login_status == "logged in"
			session[:user] = "yes"
			session[:time] = Time.now
			flash[:error] = ""
  			redirect_to urls_new_path
  			return
		end
	end
=begin
called when user clicks submit button on signup page
=end
	def signup_entry
		#1 - checks if field is empty
		if check_if_empty(signup_params[:username], signup_params[:password], signup_params[:email], signup_params[:fullname], signup_params[:confirm_password]) == true
			flash[:error] = "empty field not allowed"
			render users_signup_path
			return
		end
		#2 - checks if username is available or taken
		if User.check_username_available(signup_params) == false
			flash[:error] = "Username not available"
			render users_signup_path
			return
		end
		#3 checks if both passwords entered is same
		if check_password_match(signup_params) == false
			flash[:error] = "password dont match"
			render users_signup_path
			return
		end
		User.try_signup(signup_params)
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

