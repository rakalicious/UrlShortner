class UrlsController < ApplicationController
	skip_before_action :verify_authenticity_token
	include UrlsHelper
	require 'date'
	require 'time'

	def new

		session_timeout(5)

		is_session_over_yes

		@conv = Conversion.find_by(date: Date.today)
	end

	#called when user clicks submit for long to short conversion
	def convert_long
		is_session_over_yes
		r_val = long_to_short
		#if r_val == false
		#	return

		@conv = Conversion.find_by(date: Date.today)

		render 'urls/new'
	end

	#api for long to short
	def long_to_short
		short_url = Url.shorten_url(params[:long] , params[:domain])
		puts short_url
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

	#called when user clicks submit for short to long conversion
	def convert_short
		is_session_over_yes
		short_to_long
		@conv = Conversion.find_by(date: Date.today)

		render 'urls/new'
	end

	#api for short to long
	def short_to_long
		@req_ans = Url.find_long_url(params[:short])

		if @req_ans == false
			flash[:error] = "no such short url"
			@conv = Conversion.find_by(date: Date.today)

			render urls_new_path

			return
		end
		if params[:action] == "convert_short"
			flash[:error] = ""
				return @req_ans
		else
				render json: {"long" => @req_ans}
		end
		
	end

	def logout
		close_session
	end
	
end
