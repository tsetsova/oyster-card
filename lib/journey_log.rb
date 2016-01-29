require 'journey'

class Journey_log
  attr_reader :log_history, :entry_station

  def initialize(station, journey_class: Journey)
    @log_history = []
    @entry_station = station
  end

  def start_journey
    @journey = Journey.new
  end
end
