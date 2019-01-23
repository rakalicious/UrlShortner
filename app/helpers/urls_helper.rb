module UrlsHelper

	def check_if_empty(*args)
		puts args
	end

	def new_long_incoming(long_url)
		#Rails.cache.clear
		if Url.find_by(long_url: long_url) == nil
			 @urls = Url.new({:long_url => long_url, :short_url => convert_to_short})
			 @urls.save
			 return Url.find_by(long_url: long_url).short_url
		else
			@short_url = Rails.cache.fetch(long_url , :expires_in => 5.minutes) do

				Url.where(long_url: long_url).first.short_url
				end
			return @short_url
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
			flash[:error] = "no such short url"
			render urls_new_path
			return
		else
			@long_url = Rails.cache.fetch(short_url , :expires_in => 5.minutes) do

				Url.where(short_url: short_url).first.long_url
				end
			return @long_url
			#return Url.find_by(short_url: short_url).long_url
		end
	end

	private
  		def url_params_log
    		params.permit(:long, :short)
  		end
  	
end
