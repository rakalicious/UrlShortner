class ConversionsController < ApplicationController
	def index
		@conversion = Conversion.all
	end
	
end
