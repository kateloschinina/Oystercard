require_relative 'oystercard.rb'

class Journey

  attr_accessor :entry_station, :exit_station

  def initialize(entry_station = nil, exit_station = nil)
      @entry_station = entry_station
      @exit_station = exit_station
  end

  def start_journey(station)
    @entry_station =  station
  end

  def end_journey(station)
    @exit_station = station
  end

  def calculate_fare
    Oystercard::MIN_FARE
  end

  def complete?
    !!(@entry_station && @exit_station)
  end

end
