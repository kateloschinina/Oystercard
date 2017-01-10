require 'csv'

class Station

  attr_reader :name
  attr_reader :zone

  def initialize(name)
    @name = name
    load_stations
    raise "Station doesn't exist on the map yet." if !@catalog.has_key?(@name)
    @zone = @catalog[@name]
  end

  def load_stations(filename = 'stations.csv')
    raise "No file to load stations from!" if !File.exists?(filename)
    @catalog = Hash.new
    CSV.foreach(filename) do |row|
      name = row[0]
      zone = row[1]
      @catalog.store(name,zone.to_i)
    end
  end

end
