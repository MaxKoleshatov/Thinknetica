# frozen_string_literal: true
require_relative 'train'

class PassengerTrain < Train

  attr_accessor_with_history :route_train, :type, :number, :speed, :wagons
  strong_attr_accessor :speed, Integer
 

  validate :number, :presence
  validate :number, :format_number
  validate :number, :type, String


  def initialize(data = {})
    super
    @route_train = []
    validate!
    register_instance
    @@all_train << self
  end

  def plus_wagon(wagon)
    @wagons << wagon if @speed.zero? && wagon.instance_of?(PassengerWagon)
  end

  def minus_wagon(wagon)
    @wagons.delete_at(wagon) if @speed.zero?
  end

  def train_route(route)
    super
    @route_train << route
  end
end




