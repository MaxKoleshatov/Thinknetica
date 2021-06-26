# frozen_string_literal: true

require_relative 'module_firm'
require_relative 'module_instance'

class Train
  include Firm

  include InstanceCounter

  attr_reader :number, :type, :wagons

  NUMBER_FORMAT = /^[0-9а-яa-z]{3}\p{P}*[0-9а-яa-z]{2}$/i.freeze

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
    validate!
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

  def validate!
    errors = []
    errors << 'Не верный формат номера поезда' if number !~ NUMBER_FORMAT
    if type != 'Грузовой' && type != 'Пассажирский'
      errors << "Тип поезда может быть только 'Грузовой' или 'Пассажирский'"
    end
    raise errors.join('.') if errors != []

    true
  end

  def valid?
    validate!
  rescue StandardError
    false
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
