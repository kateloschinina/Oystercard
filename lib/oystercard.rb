require_relative 'journey.rb'
require_relative 'journey_log.rb'

class Oystercard

  MAX_BALANCE = 90
  MIN_FARE = 1
  PENALTY = 6

  def initialize(amount = 0, max_balance = MAX_BALANCE, min_fare = MIN_FARE, penalty = PENALTY)
    @balance = amount
    @max_balance = max_balance
    @min_fare = min_fare
    @penalty = penalty
    @history = JourneyLog.new
  end

  attr_accessor :max_balance, :min_fare, :penalty
  attr_reader :balance, :entry_station, :history

  def top_up(amount)
    exceed_max_balance?(amount)
    @balance += amount
  end

  def touch_in(station)
    already_in? if in_journey?
    sufficient_funds?
    @history.start_journey(station)
  end

  def touch_out(station)
    if !in_journey?
      already_out?
    else
      @history.finish_journey(station)
      deduct(@history.journey_class.calculate_fare)
    end
  end

  def in_journey?
    @history.current_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def exceed_max_balance?(amount)
    error_message = "Your card's balance cannot exceed £#{@max_balance}."
    raise error_message if @balance + amount > @max_balance
  end

  def sufficient_funds?
    error_message = "Insufficient funds for the journey."
    raise error_message if @balance < @min_fare
  end

  def already_in?
    p "You are have been charged with penalty fair of#{@penalty} as you did not touch out on your lastjourney."
    deduct(@penalty)
    @history.finish_journey("n/a")
  end

  def already_out?
    p "You are have been charged with penalty fair of #{@penalty} as you did not touch in."
    deduct(@penalty)
    touch_in("n/a")
  end
end
