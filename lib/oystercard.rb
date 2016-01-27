require_relative "journey"

class Oystercard
	attr_reader :balance, :station
	TOP_UP_LIMIT = 90
	MIN_FARE = 1

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
    @current_journey = @journey_class.new
  	@current_journey.starts(station)
  end

  def touch_out(station)
  	deduct(MIN_FARE)
  	@current_journey.ends(station)
  	# @journeys << @journey
  end

  private

  def deduct(amount)
  	@balance -= amount
  end

  def exceeds_balance(amount)
    (@balance + amount) > TOP_UP_LIMIT
  end
end