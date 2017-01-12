class JourneyLog

attr_reader :journeys

def initialize(journey_class: Journey)
@journey_class = journey_class
@journeys = Hash.new
end

def start_journey (station)
@current_journey = Journey.new(station)
end

def finish_journey(station)
  @current_journey.exit_station = station
  @journey_log.store("j#{@journeys.length+1}", [@current_journey.entry_station, @current_journey.exit_station])
end

private

def current_journey
  @current_journey || Journey.new
end



end
