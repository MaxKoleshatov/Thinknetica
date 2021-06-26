# frozen_string_literal: true

class PassengerTrain < Train
  attr_reader :route_train, :type, :number, :speed, :wagons

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
