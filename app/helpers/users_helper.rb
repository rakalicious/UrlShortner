module UsersHelper

	#checks fields if they are empty
	def check_if_empty(*args) 
		for i in args
			puts i
			if i == ""
				return true
			end
			return false
		end
	end

	def check_password_match(signup_params)
		if signup_params[:password] == signup_params[:confirm_password]
			return true
		end
			return false
	end

	#if session is not over then redirects user to login page else keeps on current page
	def is_session_over_no
		if session[:user] == "yes"
			redirect_to urls_new_path
			return
		end
	end
	
end
