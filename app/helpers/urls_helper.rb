module UrlsHelper

	def check_if_empty(*args)
		for i in args
			if i == ""
				return false
			end
			return true
		end
	end

	
	def self.convert_to_short(number) 
		charset = Array('A'..'Z') + Array('a'..'z') + Array('0'..'9')
  		return Array.new(number) { charset.sample }.join

	end


	private
  		def url_params_log
    		params.permit(:long, :short)
  		end
  	
end
