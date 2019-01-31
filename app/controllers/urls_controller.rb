class UrlsController < ApplicationController
	skip_before_action :verify_authenticity_token
	include UrlsHelper
	require 'date'
	require 'time'
 
	def new
		#session_timeout(10)
		if is_session_over_yes == true
			redirect_to users_new_user_path
			return
		end
	end

=begin
called when user clicks submit for long to short conversion
=end
	def convert_long
		#session_timeout(10)
		if is_session_over_yes == true
			redirect_to users_new_user_path
			return
		end
		if long_to_short == false
			@req_ans = ""
			flash.now[:error] = "Domain not registered"
		end
		render 'urls/new'
	end
=begin
api for long to short (POST)
inp = POST  http://0.0.0.0:3000/urls/long_to_short ....... and in body    {"long" : "www.youtube.com/charmander" ,
																		# "domain" : "youtube"}
out = {"domain":"bpGa","short":"CDdyqEG"}
=end
	def long_to_short
		domain_name = DomainsHelper.get_domain_name_from_url(params[:long_url_inp])
		@req_ans = Url.shorten_url(params[:long_url_inp] , domain_name)
		if @req_ans == false
			return false
		end
		if params[:action] == "convert_long"
			return
		else
			render json: {"domain" => @req_ans.split("/").first , "short" => @req_ans.split("/").last}
		end
	end
=begin
called when user clicks submit for short to long conversion
=end
	def convert_short
		#session_timeout(10)
		if is_session_over_yes == true
			redirect_to users_new_user_path
			return
		end
		short_to_long
		render 'urls/new'
	end
=begin
api for short to long
inp = GET  http://0.0.0.0:3000/urls/short_to_long?short=47FbPzI
out = {"long":"bulbasaur"}
=end
	def short_to_long
		short_inp = params[:short_url_inp]
		if short_inp.include? "/"
			short_inp = short_inp.split("/").second
		end
		@req_ans = Url.find_long_url(short_inp)
		if @req_ans == false
			flash.now[:error] = "no such short url"
			@req_ans = ""
			return
		end
		if params[:action] == "convert_short"
			return
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

	private
  	def url_params
    	params.permit(:short_url_inp , :long_url_inp)
  	end
	
end
