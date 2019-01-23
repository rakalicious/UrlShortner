class UsersController < ApplicationController

	include UsersHelper
	require 'time'

	def new_user
		if session[:user] == "yes"
			redirect_to urls_new_path
			return
		end
		session[:user] = "no"
	end

	def signup
		if session[:user] == "yes"
			redirect_to urls_new_path
		end
	end

	def login

		if check_if_empty(params[:username] , params[:password]) == false
			flash[:error] = "Field cannot be empty"
  			redirect_to root_path
			return
		end

		login_status = User.try_login(params[:username],params[:password])

		if login_status == "wrong username"
			flash[:error] = "Wrong username. Try Again"
  			redirect_to root_path
			return

		elsif login_status == "wrong password"
			flash[:error] = "Wrong password. Try Again"
			redirect_to root_path
			return

		elsif login_status == "logged in"
			session[:user] = "yes"
			session[:time] = Time.now
			#session[:time] = Time.now.strftime("%H:%M:%S")
  			redirect_to urls_new_path
  			return

		else
			puts "something wrong"
		end

	end


	def signup_entry
		puts "hey heyhey"
		puts params
		if check_if_empty(params[:username], params[:password], params[:email], params[:fullname], params[:confirm_password]) == false
			flash[:error] = "error in field"
			puts "empty"
			redirect_to users_signup_path
			return
		end
		if check_pass_match(params[:password] , params[:confirm_password]) == false
			flash[:error] = "error in field"
			redirect_to users_signup_path
			return
		end

		User.try_signup(params[:username], params[:password], params[:email], params[:fullname])
		redirect_to users_new_user_path
	end

	def username_available
		
	end

end

private
  	def login_params
    	puts params.require(:login).permit(:username, :password)
  	end
  	def signup_params
   		params.require(:login).permit(:username, :password, :email, :fullname)
  	end

