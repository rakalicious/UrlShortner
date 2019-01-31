module UrlsHelper

  def check_if_empty(allowed_params) 
    for i in allowed_params.keys
      if allowed_params[i] == ""
        return true
      end
    end
    return false
  end   

=begin
generate nbit random string of length num
=end
  def self.random_62bit_string
    charset = Array('A'..'Z') + Array('a'..'z') + Array('0'..'9')
    return Array.new(ApplicationController::RANDOM_STRING_LENGTH) { charset.sample }.join
  end

=begin
close the session
=end
  def close_session
		session[:user] = "no"
		redirect_to users_new_user_path
	end
  	
end
