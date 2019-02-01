class ConversionsController < ApplicationController
  before_action :is_session_over_no, only: []
  before_action :is_session_over_yes, only: [:index]
  
  def index
    @conversion = Conversion.all
  end  
end
