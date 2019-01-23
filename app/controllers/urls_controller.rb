class UrlsController < ApplicationController
	include UrlsHelper
	require 'date'

	def new
		if session[:user] == "no"
			redirect_to users_new_user_path
		end
		@conv = Conversion.find_by(date: Date.today)
		puts @conv.count
	end

	def convert_long
		params[:commit] = new_long_incoming(params[:long])
		#params[:commit] = ''
		#@login = Login.find(params[:id])
				@conv = Conversion.find_by(date: Date.today)

		render 'urls/new'
	end

	def convert_short
		params[:commit] = find_long_url(params[:short])
		#params[:commit] = ''
		#@login = Login.find(params[:id])
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
