require_relative "journey"

class Oystercard
	attr_reader :balance, :station
	TOP_UP_LIMIT = 90
	MIN_FARE = 1
	PENALTY_FARE = 6

	def initialize(journey_class: Journey)
		@balance = 0
		# @journeys = []
		@journey_class = journey_class
		@station = station
	end

	def top_up(amount)
  	fail "Exceeds £#{TOP_UP_LIMIT} top up limit." if exceeds_balance(amount)
    @balance += amount
  end

  def touch_in(station)
  	fail 'Insufficient funds' if @balance < MIN_FARE
		return deduct(PENALTY_FARE) if @touched_in == true
    @current_journey = @journey_class.new
		@touched_in = true
  	@current_journey.starts(station)
  end

  def touch_out(station)
		return deduct(PENALTY_FARE) if @touched_in == nil
  	deduct(MIN_FARE)
  	@current_journey.ends(station)
  	# @journeys << @journey
	end

	def touched_in?
		@touched_in
  end


  private

  def deduct(amount)
  	@balance -= amount
  end

  def exceeds_balance(amount)
    (@balance + amount) > TOP_UP_LIMIT
  end
end
