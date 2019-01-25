class CounterInitWorker
  include Sidekiq::Worker
  require 'date'

  def perform_init

    if Conversion.find_by(date: Date.today) == nil
      #count_today = Conversion.create(:date => Date.today , :count => 1)
      Conversion.create(:date => Date.today , :count => 0)
    end

  end

end
