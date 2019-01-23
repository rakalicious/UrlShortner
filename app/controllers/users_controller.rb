class UsersController < ApplicationController

	include UsersHelper

	def new_user
	end

	def signup

	end

	def login

		if check_if_empty(params[:username] , params[:password]) == false
			flash[:error] = "Field cannot be empty"
  			redirect_to root_path
			return
		end

		login_status = try_login(params[:username],params[:password])

		if login_status == "wrong username"
			flash[:error] = "Wrong username. Try Again"
  			redirect_to root_path
			return

		elsif login_status == "wrong password"
			flash[:error] = "Wrong password. Try Again"
			redirect_to root_path
			return

		elsif login_status == "logged in"
  			redirect_to urls_new_path
  			return

		else
			puts "something wrong"
		end

	end


	def signup_entry
		if check_if_empty(params[:username], params[:password], params[:email], params[:fullname]) == false
			flash[:error] = "error in field"
			redirect_to users_signup_path
			return
		end
		try_signup(params[:username], params[:password], params[:email], params[:fullname])
		redirect_to users_new_user_path
	end

end

private
  	def login_params
    	puts params.require(:login).permit(:username, :password)
  	end
  	def signup_params
   		params.require(:login).permit(:username, :password, :email, :fullname)
  	end

