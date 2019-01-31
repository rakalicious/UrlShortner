class ApplicationController < ActionController::Base

before_action :session_timeout
=begin
checks if session allowed time is over
=end
  def session_timeout
  	time = 12
  	puts "ysys checking"
    if (Time.parse(DateTime.now.to_s) - Time.parse(session[:time].to_s))/60 > time
      session[:user] = "no"
    end
  end
end
