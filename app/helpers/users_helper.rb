module UsersHelper

	def check_if_empty(*args) 
		for i in args
			puts i
			if i == ""
				return true
			end
			return false
		end
	end

	def check_password_match(pass, confirm_pass)
		if pass == confirm_pass
			return true
		end
			return false
	end

	def is_session_over_no
		if session[:user] == "yes"
			redirect_to urls_new_path
			return
		end
	end
	
end
