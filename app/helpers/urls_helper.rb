module UrlsHelper
	def new_long_incoming(long_url)
		if Url.find_by(long_url: long_url) == nil
			 @urls = Url.new({:long_url => long_url, :short_url => convert_to_short})
			 @urls.save
			 puts "hey"
			 return Url.find_by(long_url: long_url).short_url
		else
			return Url.find_by(long_url: long_url).short_url
			#render json: {"h" : "hello"}
		end
	end
	def convert_to_short
		number = 7
		charset = Array('A'..'Z') + Array('a'..'z') + Array('0'..'9')
  		return Array.new(number) { charset.sample }.join

	end

	def find_long_url(short_url)
		if Url.find_by(short_url: short_url) == nil
			puts "no such short url"
		else
			return Url.find_by(short_url: short_url).long_url
		end
	end

	private
  		def url_params_log
    		params.permit(:long, :short)
  		end
  	
end
