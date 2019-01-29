class SearchController < ApplicationController
  def search
      if params[:q].nil?	
    		@urls = []
  		else
    		@urls = Url.search params[:q]
  		end
	end
end
