class Journey

  attr_reader :entry_station, :exit_station

  def initialize entry_station
    @entry_station = entry_station
  end

  def end_journey station
    @exit_station = station
  end

end
