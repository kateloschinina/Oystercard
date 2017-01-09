class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = -5

  def initialize(amount = 0, min_balance = MIN_BALANCE, max_balance = MAX_BALANCE)
    @balance = amount
    @min_balance = min_balance
    @max_balance = max_balance
  end

  attr_accessor :min_balance
  attr_accessor :max_balance
  attr_reader :balance

  def top_up(amount)
    error_message = "Your card's balance cannot exceed £#{@max_balance}."
    raise error_message if @balance + amount > @max_balance
    @balance += amount
  end

  def deduct(amount)
    error_message = "Your card's balance can't go below £#{@min_balance}."
    raise error_message if @balance - amount < @min_balance
    @balance -= amount
  end

end
