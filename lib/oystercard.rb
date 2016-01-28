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
    deduct Journey::PENALTY_FARE if !@journey.nil?
    fail "Insufficient funds" if balance < MINIMUM_CHARGE
    @journey = Journey.new station
  end

  def touch_out(station)
    @journey = Journey.new if @journey.nil?
    @journey.end_journey station
    deduct MINIMUM_CHARGE
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
