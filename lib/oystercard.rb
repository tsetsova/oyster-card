require_relative 'station'
require_relative 'journey'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  # TODO: remove some readers
  attr_reader :balance, :entry_station, :history, :exit_station, :journey, :entry_zone, :exit_zone

  def initialize
    @balance = 0
    @history = []
    # TODO: implement Journey obj
    @journey = Hash.new
  end

  def top_up amount
    fail "Balance has exceeded limit of #{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

   def in_journey?
     # TODO: journey
     !entry_station.nil?
   end

  def touch_in(station)
    fail "Insufficient funds" if balance < MINIMUM_BALANCE
    #@journey = Hash.new
    # TODO: journey
    @entry_station = true
    @entry_zone = station.zone
    @journey[:entry_station] = station
  end

  def touch_out(station)
    @entry_station = nil
    deduct MINIMUM_CHARGE
    @journey[:exit_station] = station
    @exit_zone = station.zone
    @history << @journey
    # @journey = Hash.new
  end

  private
  def deduct amount
    @balance -= amount
  end

end
