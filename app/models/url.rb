class Url < ApplicationRecord
	after_create :start

	def start
		CounterWorker.perform_async
	end
end
