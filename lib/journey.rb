class Journey
  PENALTY_FARE = 6
  MINIMUM_CHARGE = 1

  attr_reader :entry_station, :exit_station

  def initialize(station = nil)
    @entry_station = station
    @exit_station = nil
  end

  def end_journey(station)
    @exit_station = station
  end

  def calculate_fare
    return PENALTY_FARE if exit_station.nil? || entry_station.nil?
    (entry_station.zone - exit_station.zone).abs + MINIMUM_CHARGE
  end
end
