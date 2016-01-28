require_relative 'station'
require_relative 'journey'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  # TODO: remove some readers
  attr_reader :balance, :entry_station, :history, :exit_station, :journey, :entry_zone, :exit_zone

  def initialize
    @balance = 0
    @history = []
    @entry_station = nil
    @exit_station = nil
    # TODO: implement Journey obj
    @journey = Hash.new
    @current_journey = nil
  end

  def top_up amount
    fail "Balance has exceeded limit of #{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

   def in_journey?
     !@current_journey.nil?
   end

  def touch_in(station)
    fail "Insufficient funds" if balance < MINIMUM_CHARGE
    #@journey = Hash.new
    # TODO: journey
    @entry_station = true
    @current_journey = Journey.new station
    @journey[:entry_station] = station
  end

  def touch_out(station)
    @entry_station = nil
    @current_journey.end_journey(station)
    deduct MINIMUM_CHARGE
    @journey[:exit_station] = station
    journey_log
    @current_journey = nil
    @exit_zone = station.zone
  end

  private
  def deduct amount
    @balance -= amount
  end

  def journey_log
    @history << @journey
  end
end
