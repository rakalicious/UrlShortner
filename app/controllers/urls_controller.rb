class UrlsController < ApplicationController
	include UrlsHelper
	require 'date'
	require 'time'

	def new
		puts params
		puts (Time.parse(DateTime.now.to_s) - Time.parse(session[:time].to_s))

		if (Time.parse(DateTime.now.to_s) - Time.parse(session[:time].to_s))/60 > 5
			session[:user] = "no"
		end

		if session[:user] == "no"
			redirect_to users_new_user_path
			return
		end

		@conv = Conversion.find_by(date: Date.today)
	end

	def convert_long
		puts params
		dom_short = Url.new_domain_incoming(params[:domain] , 4)
		short = Url.new_long_incoming(params[:long] , dom_short ,7)
		params[:commit] = dom_short +"."+ short 
		@conv = Conversion.find_by(date: Date.today)

		render 'urls/new'
	end

	def convert_short
		params[:commit] = Url.find_long_url(params[:short])
		@conv = Conversion.find_by(date: Date.today)

		render 'urls/new'
	end

	def logout
		session[:user] = "no"
		redirect_to users_new_user_path
	end
	#def convert_url
	#	
	#	puts params
	#	if params[:commit] == 'Long to Short'
	#		params[:commit] = new_long_incoming(params[:long])
	#		#params[:commit] = ''
	#		#@login = Login.find(params[:id])
	#		render 'urls/new'
	#		return
	#	end
	#	if params[:commit] == 'Short to Long' 
	#		params[:commit] = find_long_url(params[:short])
	#		#params[:commit] = ''
	#		#@login = Login.find(params[:id])
	#		render 'urls/new'
	#		return
	#	end
	#end
end
