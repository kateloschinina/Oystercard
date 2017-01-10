class Oystercard

  MAX_BALANCE = 90
  #MIN_BALANCE = -5
  MIN_FARE = 1

  def initialize(amount = 0, max_balance = MAX_BALANCE, min_fare = MIN_FARE)
    @balance = amount
    #@min_balance = min_balance
    @max_balance = max_balance
    @min_fare = min_fare
  end

  #attr_accessor :min_balance
  attr_accessor :max_balance
  attr_accessor :min_fare
  attr_reader :balance
  attr_reader :entry_station

  def top_up(amount)
    exceed_max_balance?(amount)
    @balance += amount
  end

  def touch_in(station)
    already_in?
    sufficient_funds?
    @entry_station = station
  end

  def touch_out
    already_out?
    deduct(@min_fare)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct(amount)
    #exceed_min_balance?(amount)
    @balance -= amount
  end

  def exceed_max_balance?(amount)
    error_message = "Your card's balance cannot exceed £#{@max_balance}."
    raise error_message if @balance + amount > @max_balance
  end

  #def exceed_min_balance?(amount)
  #  error_message = "Your card's balance can't go below £#{@min_balance}."
  #  raise error_message if @balance - amount < @min_balance
  #end

  def already_in?
    error_message = "You have already touched in!"
    raise error_message if @entry_station
  end

  def already_out?
    error_message = "You have already touched out!"
    raise error_message if !@entry_station
  end

  def sufficient_funds?
    error_message = "Insufficient funds for the journey."
    raise error_message if @balance < @min_fare
  end

end
