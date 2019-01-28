class Conversion < ApplicationRecord
	require 'date'
	require 'time'
	
	def self.get_conv
		@conv = Conversion.find_by(date: Date.today)

	end
end
