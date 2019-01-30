module UsersHelper

=begin
checks fields if they are empty
=end
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
=begin
if session is not over then redirects user to login page else keeps on current page
=end
	def is_session_over_no
		if session[:user] == "yes"
			return true
		end
	end
	
end
