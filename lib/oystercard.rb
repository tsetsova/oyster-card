class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

 attr_reader :balance, :entry_station

  def initialize
    @balance = 0

  end

  def top_up amount
    fail "Balance has exceeded limit of #{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

   def in_journey?
     !!entry_station
   end

  def touch_in(station)
  fail "Insufficient funds" if balance < MINIMUM_BALANCE
    @entry_station = true
  end

  def touch_out
   @entry_station = nil
    deduct MINIMUM_CHARGE

  end

  private
  def deduct amount
    @balance -= amount
  end

end
