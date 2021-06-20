require_relative 'wagon'

class PassengerWagon < Wagon

  attr_reader :type, :all_passenger_seat, :free_passenger_seat, :off_passenger_seat
       
  def initialize(free_seat)
    @type = "Пассажирский"
    @all_passenger_seat = free_seat
    @free_passenger_seat = free_seat
    @off_passenger_seat = 0
  end

  def remove_place
    @free_passenger_seat -= 1
    @off_passenger_seat += 1
  end 
end

