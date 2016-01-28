

class JourneyLog

	def initialize(journey_class: Journey)
		@journey_class = journey_class
	end

	def starts_journey(station)
		@journey = @journey_class.new
		@journey.starts(station) # <-----
	end
end