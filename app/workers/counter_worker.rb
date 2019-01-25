class CounterWorker
  include Sidekiq::Worker
  require 'date'

  def perform
    # Do something
      if Conversion.find_by(date: Date.today) == nil
        puts "wrong"
      #count_today = Conversion.create(:date => Date.today , :count => 1)
      Conversion.create(:date => Date.today , :count => 0)
    else
      puts "correct"
    	count_today = Conversion.find_by(date: Date.today)
      puts count_today.count
    	live_count = count_today.count
    	count_today.update(count: live_count + 1)
    end
  end

end
