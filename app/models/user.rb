class User < ApplicationRecord
	validates :username, presence: true
	validates :password, presence: true 
	validates :email, presence: true
	validates :name, presence: true

	def self.try_login(username , password)
		if User.find_by(username: username) == nil
			return "wrong username"
		elsif User.find_by(username: username).password != password
			return "wrong password"
		else
			return "logged in"
		end
	end


	def self.try_signup(username, password, email, fullname)
		@users = User.create({:username => username , :password => password , :email => email , :name => fullname})
		#@users.save
	end

	def self.check_username_available(username)
		if User.find_by(username: username) == nil
			return true
		end
		return false
	end

end
