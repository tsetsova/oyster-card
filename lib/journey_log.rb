require_relative 'journey'

class Journey_log
  attr_reader :log_history, :entry_station

  def initialize(journey_class: Journey)
    @log_history = []
  end

  def start_journey(station)
    @journey = Journey.new
  end

  def end_journey(station)
  	@journey.end_journey(station)
  end

  def collects_log
  	@log_history << @journey
  end

  def view_history
  	@log_history.dup
  end
end
