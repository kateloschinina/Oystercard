class Oystercard

  def initialize(amount = 0)
    @balance = amount
  end

  attr_reader :balance

  def top_up(amount)
    @balance += amount
  end

end
