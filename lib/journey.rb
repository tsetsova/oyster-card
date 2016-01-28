class Journey
  PENALTY_FARE = 6
  MINIMUM_CHARGE = 1
  
  attr_reader :entry_station, :exit_station

  def initialize(station)
    @entry_station = station
  end

  def end_journey station
    @exit_station = station
  end

  def calculate_fare
    PENALTY_FARE
  end

end
