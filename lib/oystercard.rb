class Oystercard
	attr_reader :balance

	TOP_UP_LIMIT = 90
	MIN_FARE = 1

	def initialize
		@balance = 0
		@in_journey = false
	end

	def top_up(amount)
  	fail "Exceeds £#{TOP_UP_LIMIT} top up limit." if (@balance + amount) > TOP_UP_LIMIT
    @balance += amount
  end

  def in_journey?
  	@in_journey
  end

  def touch_in
  	fail 'Insufficient funds' if @balance < MIN_FARE
  	@in_journey = true
  end

  def touch_out
  	@in_journey = false
  	deduct(MIN_FARE)
  end

  private

   def deduct(amount)
  	@balance -= amount
  end
end