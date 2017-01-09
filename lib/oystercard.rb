class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = -5

  def initialize(in_journey = false, amount = 0, min_balance = MIN_BALANCE, max_balance = MAX_BALANCE)
    @balance = amount
    @min_balance = min_balance
    @max_balance = max_balance
    @in_journey = in_journey
  end

  attr_accessor :min_balance
  attr_accessor :max_balance
  attr_reader :balance
  attr_accessor :in_journey

  def top_up(amount)
    exceed_max_balance?(amount)
    @balance += amount
  end

  def deduct(amount)
    exceed_min_balance?(amount)
    @balance -= amount
  end

  def touch_in
    already_in?
    @in_journey = true
  end

  def touch_out
    already_out?
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def exceed_max_balance?(amount)
    error_message = "Your card's balance cannot exceed £#{@max_balance}."
    raise error_message if @balance + amount > @max_balance
  end

  def exceed_min_balance?(amount)
    error_message = "Your card's balance can't go below £#{@min_balance}."
    raise error_message if @balance - amount < @min_balance
  end

  def already_in?
    error_message = "You have already touched in!"
    raise error_message if @in_journey
  end

  def already_out?
    error_message = "You have already touched out!"
    raise error_message if !@in_journey
  end

end
