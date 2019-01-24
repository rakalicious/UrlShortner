module UrlsHelper

	def check_if_empty(*args)
		for i in args
			if i == ""
				return false
			end
			return true
		end
	end

	
	def self.random_n_string(number , n_bit = 62) 
		charset = Array('A'..'Z') + Array('a'..'z') 

		if n_bit == 62
			charset = charset + Array('0'..'9')
		end
  		return Array.new(number) { charset.sample }.join

	end
	def session_timeout(time)
		if (Time.parse(DateTime.now.to_s) - Time.parse(session[:time].to_s))/60 > time
			session[:user] = "no"
		end
	end

	def is_session_over_yes
		if session[:user] == "no"
			redirect_to users_new_user_path
			return
		end
	end

	def close_session
		session[:user] = "no"
		redirect_to users_new_user_path
	end
  	
end
