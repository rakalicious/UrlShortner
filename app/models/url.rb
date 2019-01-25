class Url < ApplicationRecord
	after_create :start

	validates :long_url, presence: true
	validates :short_url, presence: true


	def start
		CounterWorker.perform_async
	end

	def self.random_string_for_domain(number)
		possible_domain = UrlsHelper.random_n_string(4,number)
		while Domain.find_by(short_domain: possible_domain) != nil do
			possible_domain = UrlsHelper.random_n_string(4,number)
		end
		return possible_domain
	end

	def self.random_string_for_url(number)
		possible_short = UrlsHelper.random_n_string(7,number)
		while Url.find_by(short_url: possible_short) != nil do
			possible_short = UrlsHelper.random_n_string(7,number)
		end
		return possible_short
	end

	def self.shorten_url(long_url , long_domain)
		number = 62
		if Url.find_by(long_url: long_url) == nil
			short_domain = Url.find_short_domain(long_domain)
			possible_short = Url.random_string_for_url(number)
			#puts short_domain
			#puts possible_short

			@short_url = Url.create({:long_url => long_url, :short_url => possible_short , :short_domain => short_domain})
			#@urls.save
			return (short_domain)+"/"+(Url.find_by(long_url: long_url).short_url)
		else
			#short_domain = Url.find_by(long_url: long_url).short_domain
			#actual_domain = Domain.find_by(short_domain: short_domain).domain_name
			@short_url = Rails.cache.fetch(long_url , :expires_in => 5.minutes) do
				a = (Url.where(long_url: long_url).first.short_domain )
				puts a
				b = (Url.where(long_url: long_url).first.short_url)
				puts b
				a+"/" +b
				end
			return @short_url
		end

	end
=begin
	def self.new_long_incoming(long_url ,dom_short , number)
		#Rails.cache.clear
		if Url.find_by(long_url: long_url) == nil

			possible_short = UrlsHelper.random_n_string(number)
			while Url.find_by(short_url: possible_short) != nil do
				possible_short = UrlsHelper.random_n_string(number)
			end

			@urls = Url.create({:long_url => long_url, :short_url => possible_short , :short_domain => dom_short})
			#@urls.save
			return Url.find_by(long_url: long_url).short_url

		else
			@short_url = Rails.cache.fetch(long_url , :expires_in => 5.minutes) do

				Url.where(long_url: long_url).first.short_domain + Url.where(long_url: long_url).first.short_url
				end
			return @short_url
		end
	end
=end
	def self.find_short_domain(long_domain)
		number = 52
		#Rails.cache.clear
		if Domain.find_by(domain_name: long_domain) == nil
			possible_domain = Url.random_string_for_domain(number)
			@short_domain = Domain.create({:domain_name => long_domain, :short_domain => possible_domain})
			#@domains.save
			return Domain.find_by(domain_name: long_domain).short_domain
		else
			@short_domain = Rails.cache.fetch(long_domain , :expires_in => 5.minutes) do

				Domain.where(domain_name: long_domain).first.short_domain
				end
			return @short_domain
		end
	end

	def self.find_long_url(short_url)
		if Url.find_by(short_url: short_url) == nil
			return "no such short url exist"
		else
			@long_url = Rails.cache.fetch(short_url , :expires_in => 5.minutes) do

				Url.where(short_url: short_url).first.long_url
				end
			return @long_url
			#return Url.find_by(short_url: short_url).long_url
		end
	end

end
