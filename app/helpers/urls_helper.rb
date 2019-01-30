module UrlsHelper

	def check_if_empty(*args)
		for i in args
			if i == ""
				return false
			end
			return true
		end
	end

=begin
generate nbit random string of length num
=end
	def self.random_n_string(number , n_bit = 62) 
		charset = Array('A'..'Z') + Array('a'..'z') 
		if n_bit == 62
			charset = charset + Array('0'..'9')
		end
  		return Array.new(number) { charset.sample }.join

	end
=begin
checks if session allowed time is over
=end
	def session_timeout(time)
		if (Time.parse(DateTime.now.to_s) - Time.parse(session[:time].to_s))/60 > time
			session[:user] = "no"
		end
	end
=begin
#if seesion got over then user is redirected to login page
=end
	def is_session_over_yes
		if session[:user] == "no"
			return true
		end
	end

=begin
close the session
=end
	def close_session
		session[:user] = "no"
		redirect_to users_new_user_path
	end
  	
end
