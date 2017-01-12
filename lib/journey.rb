require_relative 'oystercard.rb'
require_relative 'station.rb'

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
    if complete?
      entry_station = Station.new(@entry_station)
      exit_station = Station.new(@exit_station)
      return (entry_station.zone - exit_station.zone).abs+1
    else
      raise "It is not possible to culculate fare for uncompleted journey"
    end
  end

  def complete?
    !!(@entry_station && @exit_station)
  end

end
