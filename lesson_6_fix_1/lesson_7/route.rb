require_relative 'module_instance'

class Route

  include InstanceCounter
  
  attr_reader :stations, :intermediate_stations, :starting_station, :end_station

  NAME_FORMAT = /^[а-я]{1,}$/i

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    validate!
    register_instance
    @intermediate_stations = []
    @stations = [@starting_station, @end_station]
    end

  def add_station(name)
    @stations.insert(-2, name)
    @intermediate_stations << name
  end

  def delete_stations(name)
    @stations.delete_at(name + 1)
    @intermediate_stations.delete_at(name)
  end
  
  def validate!
    raise "Название станций должны быть указаны русскими буквами" if starting_station.name !~ NAME_FORMAT || end_station.name !~ NAME_FORMAT  
    true
  end

  def valid?
    validate!
  rescue
    false    
  end
end
