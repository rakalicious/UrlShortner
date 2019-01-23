class Url < ApplicationRecord
	after_create :start

	validates :long_url, presence: true
	validates :short_url, presence: true


	def start
		CounterWorker.perform_async
	end
end
