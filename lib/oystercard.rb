class Oystercard
 attr_reader :balance
 def initialize
  @balance = 0
 def top_up amount
  @balance += amount

end
 end
  end
