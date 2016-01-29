require_relative 'journey'

class Journey_log
  attr_reader :log_history, :entry_station

  def initialize(journey_class: Journey)
    @log_history = []
  end

  def start_journey station
    @journey = Journey.new
    @entry_station = station
  end
end
