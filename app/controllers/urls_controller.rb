class UrlsController < ApplicationController
	skip_before_action :verify_authenticity_token
	include UrlsHelper
	require 'date'
	require 'time'

	def new
		session_timeout(10)
		if is_session_over_yes == true
			redirect_to users_new_user_path
			return
		end
		@conv = Conversion.get_conv
		#@conv = Conversion.find_by(date: Date.today)
	end

=begin
called when user clicks submit for long to short conversion
=end
	def convert_long
		session_timeout(10)
		if is_session_over_yes == true
			redirect_to users_new_user_path
			return
		end
		long_to_short
		@conv = Conversion.get_conv
		render 'urls/new'
	end
=begin
api for long to short (POST)
inp = POST  http://0.0.0.0:3000/urls/long_to_short ....... and in body    {"long" : "charmander" ,
																		# "domain" : "www.youtube.com"}
out = {"domain":"bpGa","short":"CDdyqEG"}
=end
	def long_to_short
		#if domain_name.start_with?("")
		#domain_name = (Domainatrix.parse(params[:long])).domain

		domain_name = DomainsHelper.get_domain_from_url(params[:long])
		#short_url = Url.shorten_url(params[:long] , params[:domain])
		short_url = Url.shorten_url(params[:long] , domain_name)
		@req_ans = short_url
		if short_url == false
			@req_ans = "something went wrong"
			flash[:error] = "wrong domain"
			return
		end
		#@req_ans = short_domain +"/"+ short_url
		if params[:action] == "convert_long"
			flash[:error] = ""
			return @req_ans
		else
			render json: {"domain" => @req_ans.split("/").first , "short" => @req_ans.split("/").last}
		end
	end
=begin
called when user clicks submit for short to long conversion
=end
	def convert_short
		session_timeout(10)
		if is_session_over_yes == true
			redirect_to users_new_user_path
			return
		end
		if short_to_long == false
			return
		end

		@conv = Conversion.get_conv

		render 'urls/new'
	end
=begin
api for short to long
inp = GET  http://0.0.0.0:3000/urls/short_to_long?short=9sGKdAY
out = {"long":"bulbasaur"}
=end
	def short_to_long
		@req_ans = Url.find_long_url(params[:short])
		if @req_ans == false
			flash[:error] = "no such short url"
			@req_ans = ""
			@conv = Conversion.get_conv
			render urls_new_path
			return false
		end
		if params[:action] == "convert_short"
			flash[:error] = ""
			return @req_ans
		else
			render json: {"long" => @req_ans}
		end
	end
=begin
logout button
=end
	def logout
		close_session
	end
	
end
