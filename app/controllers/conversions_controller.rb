class ConversionsController < ApplicationController
	def show
		@conversion = Conversion.all
	end
	
end
