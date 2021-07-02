# frozen_string_literal: true

require_relative 'module_instance'
require_relative 'module_accessors'
require_relative 'module_validation'

class Station

  extend Accessors

  include InstanceCounter

  include Validation

  attr_accessor_with_history :trains, :name
  strong_attr_accessor :trains, Array
  
  validate :name, :presence
  validate :name, :format_name
  validate :name, :type, String

  @@all_station = []

  def self.all
    @@all_station
  end

  def initialize(name)
    @name = name
    validate!
    register_instance
    @trains = []
    @@all_station << self.name
  end

  def add_train(train)
    @trains << train
  end

  def train_by_type(type)
    @train.select { |x| x.type == type }
  end

  def start(train)
    @trains.delete(train)
  end
  
  def block_station(&block_station)
    block_station.call(trains)
  end
end


