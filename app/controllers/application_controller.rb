class ApplicationController < ActionController::Base

before_action :session_timeout, :is_session_over_yes, :is_session_over_no
MAX_SESSION_TIME = 10
RANDOM_STRING_LENGTH = 7

=begin
checks if session allowed time is over
=end
  def session_timeout
    if (Time.parse(DateTime.now.to_s) - Time.parse(session[:time].to_s))/60 > ApplicationController::MAX_SESSION_TIME
      session[:user] = "no"
    end
  end

=begin
#if seesion got over then user is redirected to login page
=end
  def is_session_over_yes
      if session[:user] == "no"
        redirect_to users_new_user_path
      end
  end

=begin
if session is not over then redirects user to login page else keeps on current page
=end
    def is_session_over_no
        if session[:user] == "yes"
            redirect_to urls_new_path
        end
    end

end
