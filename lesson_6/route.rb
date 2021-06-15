require_relative 'module_instance'

class Route

  include InstanceCounter
  
  attr_reader :stations, :intermediate_stations, :starting_station, :end_station

  NAME_FORMAT_ROUTE = /[а-я]$/i

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    @intermediate_stations = []
    @stations = [@starting_station, @end_station]
    register_instance 
    validate!
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
    raise "Название станций маршрута должны быть указаны только русскими буквами" if @starting_station !~ NAME_FORMAT_ROUTE
    raise "Название станций маршрута должны быть указаны только русскими буквами" if @end_station !~ NAME_FORMAT_ROUTE 
    true
  end

  def valide?
    validate!
  rescue
    false    
  end
end
