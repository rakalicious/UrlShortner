class UrlsController < ApplicationController
	skip_before_action :verify_authenticity_token
	include UrlsHelper
	require 'date'
	require 'time'

	def new
		session_timeout(5)

		if is_session_over_yes == true
			redirect_to users_new_user_path
			return
		end
		@conv = Conversion.get_conv
		#@conv = Conversion.find_by(date: Date.today)
	end

	#called when user clicks submit for long to short conversion
	def convert_long
		session_timeout(5)
		if is_session_over_yes == true
			redirect_to users_new_user_path
			return
		end

		r_val = long_to_short
		#if r_val == false
		#	return
		@conv = Conversion.get_conv

		render 'urls/new'
	end

	#api for long to short (POST)
	#inp = POST  http://0.0.0.0:3000/urls/long_to_short?long=charmander&domain=www.youtube.com
	#out = {"domain":"bpGa","short":"CDdyqEG"}

	def long_to_short
		short_url = Url.shorten_url(params[:long] , params[:domain])
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
		session_timeout(5)
		if is_session_over_yes == true
			redirect_to users_new_user_path
			return
		end
		short_to_long
		@conv = Conversion.get_conv

		render 'urls/new'
	end

	#api for short to long
	#inp = GET  http://0.0.0.0:3000/urls/short_to_long?short=9sGKdAY
	#out = {"long":"bulbasaur"}
	def short_to_long
		@req_ans = Url.find_long_url(params[:short])

		if @req_ans == false
			flash[:error] = "no such short url"
			@conv = Conversion.get_conv

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
