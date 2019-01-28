class User < ApplicationRecord
	validates :username, presence: true
	validates :password, presence: true 
	validates :email, presence: true
	validates :name, presence: true

	def self.try_login(login_params)
		if User.find_by(username: login_params[:username]) == nil
			return "wrong username"
		elsif User.find_by(username: login_params[:username]).password != login_params[:password]
			return "wrong password"
		else
			return "logged in"
		end
	end

 
	def self.try_signup(signup_params)
		@users = User.create({:username => signup_params[:username] , :password => signup_params[:password] , :email => signup_params[:email] , :name => signup_params[:fullname]})
		#@users.save
	end

	def self.check_username_available(signup_params)
		if User.find_by(username: signup_params[:username]) == nil
			return true
		end
		return false
	end

end
