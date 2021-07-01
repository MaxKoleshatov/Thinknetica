# frozen_string_literal: true

require_relative 'module_instance'
require_relative 'module_accessors'

class Route

  extend Accessors

  include InstanceCounter

 attr_accessor_with_history :stations, :intermediate_stations, :starting_station, :end_station

 strong_attr_accessor :long, Integer

  NAME_FORMAT = /^[а-я]{1,}$/i.freeze

  def initialize(stations = {})
    @starting_station = stations[:starting_station]
    @end_station = stations[:end_station]
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
    if starting_station !~ NAME_FORMAT || end_station !~ NAME_FORMAT
      raise 'Название станций должны быть указаны русскими буквами'
    end

    true
  end

  def valid?
    validate!
  rescue StandardError
    false
  end
end

