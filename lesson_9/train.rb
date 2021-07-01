# frozen_string_literal: true

require_relative 'module_firm'
require_relative 'module_instance'
require_relative 'module_accessors'
require_relative 'module_validation'

class Train

  extend Accessors

  include Validation
  
  include Firm

  include InstanceCounter

  

  attr_accessor_with_history :number, :type, :wagons, :color

  strong_attr_accessor :name, String

  validate :number, :presence
  validate :number, :format
  validate :number, :type, String

  

  @@all_train = []

  def self.find(number)
    @@all_train.each do |train|
      train if train.number == number
    end
  end

  def initialize(data = {})
    @speed = 0
    @number = data[:number]
    @type = data[:type]
    @wagons = []
    register_instance
    @@all_train << self
  end

  def go_speed(speed)
    @speed += speed
  end

  def stop_speed(speed)
    @stop_speed -= speed
    @speed = 0 if @speed.negative?
  end

  def train_route(route)
    @route = route
    @index = 0
    @route.stations[@index].add_train(self)
  end

  def forward_train
    @route.stations[@index].start(self)
    @index += 1
    @route.stations[@index].add_train(self)
  end

  def back_train
    @route.stations[@index].start(self)
    @index -= 1
    @route.stations[@index].add_train(self)
  end

  def next_station
    @route.station[@index + 1]
  end

  def previous_station
    @route.station[@index - 1] if @index.positive?
  end

  def block_train(&block_train)
    block_train.call(wagons)
  end

  # moved this method to the protected section, as on assignment it was necessary to transfer some method
  # Now, in my program, on objects of the Train (Passenger / Cargo) class, you cannot call the method current_station
  # to find out the current station.
  protected

  def current_station
    @route.station[@index]
  end
end





