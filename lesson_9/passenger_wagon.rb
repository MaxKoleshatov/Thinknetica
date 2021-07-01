# frozen_string_literal: true

require_relative 'wagon'
require_relative 'module_accessors'


class PassengerWagon < Wagon
  attr_accessor_with_history :type, :all_passenger_seat, :free_passenger_seat, :off_passenger_seat
  strong_attr_accessor :color, String


  def initialize(free_seat)
    super
    @type = 'Пассажирский'
    @all_passenger_seat = free_seat
    @free_passenger_seat = free_seat
    @off_passenger_seat = 0
  end

  def remove_place
    @free_passenger_seat -= 1
    @off_passenger_seat += 1
  end
end

