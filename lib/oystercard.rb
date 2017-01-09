class Oystercard

  MAX_BALANCE = 90

  def initialize(amount = 0, max_balance = MAX_BALANCE)
    @balance = amount
    @max_balance = max_balance
  end

  attr_accessor :max_balance
  attr_reader :balance

  def top_up(amount)
    error_message = "Your card's balance cannot exceed £#{@max_balance}."
    raise error_message if @balance + amount > @max_balance
    @balance += amount
  end

end
