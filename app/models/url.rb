class Url < ApplicationRecord
	after_create :start

	validates :long_url, presence: true
	validates :short_url, presence: true


	def start
		CounterWorker.perform_async
	end

	def self.new_long_incoming(long_url ,dom_short , number)
		#Rails.cache.clear
		if Url.find_by(long_url: long_url) == nil
			temp_converted = UrlsHelper.convert_to_short(number)
			while Url.find_by(short_url: temp_converted) != nil do
				temp_converted = UrlsHelper.convert_to_short(number)
			end



			 @urls = Url.new({:long_url => long_url, :short_url => temp_converted , :short_domain => dom_short})
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

	def self.new_domain_incoming(long_domain , number)
		#Rails.cache.clear
		if Domain.find_by(domain_name: long_domain) == nil
			temp_converted = UrlsHelper.convert_to_short(number)
			while Domain.find_by(short_domain: temp_converted) != null do
				temp_converted = UrlsHelper.convert_to_short(number)
			end



			 @domains = Domain.new({:domain_name => long_domain, :short_domain => UrlsHelper.convert_to_short(number)})
			 @domains.save
			 return Domain.find_by(domain_name: long_domain).short_domain
		else
			@short_domain = Rails.cache.fetch(long_domain , :expires_in => 5.minutes) do

				Domain.where(domain_name: long_domain).first.short_domain
				end
			return @short_domain
			#render json: {"h" : "hello"}
		end
	end


	def self.find_long_url(short_url)
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

end
