class Journey

  attr_reader :entry_station, :exit_station
  PENALTY_FARE = 6

  def end_journey station
    @exit_station = station

  end

  def start_journey station
    @entry_station = station
    @entry_zone = station.zone
  end

  def calculate_fare
    PENALTY_FARE
  end

end
