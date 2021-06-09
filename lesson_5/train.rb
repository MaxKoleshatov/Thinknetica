require_relative 'module_firm'
require_relative 'module_instance'

class Train

  include Firm

  include InstanceCounter

  attr_reader :wagon, :number

  @@all_train = []

  def self.find(number)
    @@all_train.each do |train|
      puts train if train.number == number
    end
  end
  
  def initialize(number, type, wagon)
    @speed = 0
    @number = number
    @type = type
    @wagon = wagon
    @@all_train << self
    register_instance              
  end

  def go_speed(speed) 
    @speed += speed
  end

  def stop_speed(speed)
    @stop_speed -= speed
    if @speed < 0
      @speed = 0
    end
  end
  
  def plus_wagon
    if @speed == 0 
      @wagon += 1
    else
      puts "Stop train"
    end
  end

  def minus_wagon
    if speed == 0
      @wagon -= 1
    else
      puts "Stop train"
    end
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
    if @index > 0
      @route.station[@index - 1]
    end
  end

#перенес этот метод в секцию  protected , так как по заданию нужно было перенести какой нибудь метод
#Теперь , в моей программе, на объектах класса Train(Passenger/Cargo) нельзя вызвать метод current_station
#чтобы узнать текущую станцию. 
  protected

  def current_station
    @route.station[@index]
  end
end




