class Conversion < ApplicationRecord
	require 'date'
	require 'time'
	
=begin
get conversion count value while rendering
=end
	def self.get_conv
		return Conversion.find_by(date: Date.today)
	end
end
