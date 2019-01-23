module UsersHelper

	def check_if_empty(*args)
		for i in args
			if i == ""
				return false
			end
			return true
		end
	end

	def try_login(username , password)
		if User.find_by(username: username) == nil
			return "wrong username"
		elsif User.find_by(username: username).password != password
			return "wrong password"
		else
			return "logged in"
		end
	end


	def try_signup(username, password, email, fullname)
		@users = User.create({:username => username , :password => password , :email => email , :name => fullname})
		#@users.save
	end
end
