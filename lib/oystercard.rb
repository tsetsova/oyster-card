class Oystercard
	attr_reader :balance, :entry_station

	TOP_UP_LIMIT = 90
	MIN_FARE = 1

	
	def initialize
		@balance = 0
	
	end

	def top_up(amount)
  	fail "Exceeds £#{TOP_UP_LIMIT} top up limit." if (@balance + amount) > TOP_UP_LIMIT
    @balance += amount
  end

  def in_journey?
  	@entry_station
  end

  def touch_in (station)
  	fail 'Insufficient funds' if @balance < MIN_FARE
  	@entry_station = station
  end

  def touch_out
  	@entry_station = nil
  	deduct(MIN_FARE)
  end

  private

   def deduct(amount)
  	@balance -= amount
  end
end