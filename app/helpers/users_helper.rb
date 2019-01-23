module UsersHelper

	def check_if_empty(*args)
		for i in args
			if i == ""
				return false
			end
			return true
		end
	end

	def check_pass_match(pass, confirm_pass)
		if pass == confirm_pass
			return true
		end
			return false
	end

	
end
