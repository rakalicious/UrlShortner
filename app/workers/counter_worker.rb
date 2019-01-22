class CounterWorker
  include Sidekiq::Worker
  require 'date'

  def perform
    # Do something

    if Conversion.find_by(date: Date.today) == nil
    	count_today = Conversion.create(:date => Date.today , :count => 0)
    else
    	count_today = Conversion.find_by(date: Date.today)
    	live_count = count_today.count
    	count_today.update(count: live_count + 1)
	end

  end
end
