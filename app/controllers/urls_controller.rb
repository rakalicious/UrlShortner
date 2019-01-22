class UrlsController < ApplicationController
	include UrlsHelper
	def new

	end

	def convert_url
		puts params
		if params[:commit] == 'Long to Short'
			params[:commit] = new_long_incoming(params[:long])
			#params[:commit] = ''
			#@login = Login.find(params[:id])
			render 'urls/new'
			return
		end
		if params[:commit] == 'Short to Long' 
			params[:commit] = find_long_url(params[:short])
			#params[:commit] = ''
			#@login = Login.find(params[:id])
			render 'urls/new'
			return
		end
	end
end
