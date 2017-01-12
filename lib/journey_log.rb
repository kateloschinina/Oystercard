require_relative 'journey.rb'

class JourneyLog

  attr_reader :journeys, :journey_class, :current_journey

  def initialize(journey_class = nil)
    @journey_class = journey_class
    @journeys = Hash.new
    @current_journey = false
  end

  def start_journey(station)
    @journey_class = Journey.new(station)
    @current_journey = true
  end

  def finish_journey(station)
    @journey_class.exit_station = station
    @journeys.store("j#{@journeys.length+1}", [@journey_class.entry_station, @journey_class.exit_station])
    @current_journey = false
  end

  #private

  def current_journey
    @current_journey
  end

end
