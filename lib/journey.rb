class Journey
	attr_reader :journey

	def initialize
		@journey = {}
	end

	def in_progress?
  	@journey.has_key?(:entry_station) && !@journey.has_key?(:exit_station)
  end

  def starts(station)
  	@journey[:entry_station] = station
  end

  def ends(station)
  	@journey[:exit_station] = station
  end
end