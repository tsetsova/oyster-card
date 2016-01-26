class Oystercard
	attr_reader :balance, :station, :journeys, :journey

	TOP_UP_LIMIT = 90
	MIN_FARE = 1

	
	def initialize
		@balance = 0
		@journeys = []
		@journey = {}
		@station = station
	end

	def top_up(amount)
  	fail "Exceeds £#{TOP_UP_LIMIT} top up limit." if (@balance + amount) > TOP_UP_LIMIT
    @balance += amount
  end

  def in_journey?
  	@journey.has_key?(:entry_station) && !@journey.has_key?(:exit_station)
  end

  def touch_in(station)
  	fail 'Insufficient funds' if @balance < MIN_FARE
  	@journey[:entry_station] = station
  end

  def touch_out(station)
  	deduct(MIN_FARE)
  	@journey[:exit_station] = station
  	@journeys << @journey
  end

  private

   def deduct(amount)
  	@balance -= amount
  end
end