class SearchController < ApplicationController
  before_action :is_session_over_no, only: []
  before_action :is_session_over_yes, only: [:search]
  
  def search
    if params[:q].nil?    
      @urls = []
    else
      @urls = Url.search params[:q]
    end
  end
end
