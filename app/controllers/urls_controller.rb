class UrlsController < ApplicationController
	include UrlsHelper
	require 'date'
	require 'time'

	def new

		if (Time.parse(DateTime.now.to_s) - Time.parse(session[:time].to_s))/60 > 5
			session[:user] = "no"
		end

		is_session_over_yes

		@conv = Conversion.find_by(date: Date.today)
	end

	def convert_long
		long_to_short
		
		@conv = Conversion.find_by(date: Date.today)

		render 'urls/new'
	end

	def long_to_short
		short_domain = Url.new_domain_incoming(params[:domain] , 4)
		short_url = Url.new_long_incoming(params[:long] , short_domain ,7)
		@req_ans = short_domain +"/"+ short_url
		if params[:action] == "convert_long"
			return @req_ans
		else
			render json: {"short" => @req_ans}
		end
	end

	def convert_short
		short_to_long
		@conv = Conversion.find_by(date: Date.today)

		render 'urls/new'
	end

	def short_to_long
		@req_ans = Url.find_long_url(params[:short])

		if @req_ans == "no such short url exist"
			flash[:error] = "no such short url"
					@conv = Conversion.find_by(date: Date.today)

			render urls_new_path

			return
		end
		if params[:action] == "convert_short"
				return @req_ans
		else
				render json: {"long" => @req_ans}
		end
		
	end

	def logout
		close_session
	end
	
end
