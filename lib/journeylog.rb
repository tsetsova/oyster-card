require 'journey'

class JourneyLog

	def initialize(journey_class: Journey)
		@journey_class = journey_class
		@collection = []
		@journey = @journey_class.new
	end

	def starts(station)
		@collection << @journey if @journey.in_progress?
		@journey = @journey_class.new
		@journey.starts(station)
	end

	def ends(station)
		@journey = @journey_class.new unless @journey.in_progress?
		@journey.ends(station)
		@collection << @journey
	end

	def collect
		@collection.dup
	end
end