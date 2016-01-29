require_relative 'station'
require_relative 'journey'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE  = Journey::MINIMUM_CHARGE

  attr_reader :balance, :history

  def initialize
    @balance = 0
    @history = []
    @journey = nil
  end

  def top_up amount
    fail "Balance has exceeded limit of #{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

   def in_journey?
     !@journey.nil?
   end

  def touch_in(station)
    fail "Insufficient funds" if balance < MINIMUM_CHARGE
    touch_out(nil) if in_journey?
    @journey = Journey.new station
  end

  def touch_out(station)
    @journey = Journey.new unless in_journey?
    @journey.end_journey station
    deduct(@journey.calculate_fare)
    journey_log
    @journey = nil
  end

  private
  def deduct amount
    @balance -= amount
  end

  def journey_log
    @history << @journey
  end
end
