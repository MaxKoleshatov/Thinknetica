require_relative 'module_firm'
require_relative 'module_instance'

class Train

  include Firm

  include InstanceCounter

  attr_reader :wagon
  attr_accessor :number, :type
  

  NUMBER_FORMAT = /[0-9а-яa-z]{3}\p{P}*[0-9а-яa-z]{2}$/i

def self.show
  @@all_train
end

  @@all_train = []

  def self.find(number)
    @@all_train.each do |train|
       if train.number == number
        train
       else 
       end
    end
  end
  
  def initialize(number, type, wagon)
    @speed = 0
    @number = number
    @type = type
    @wagon = wagon
    @@all_train << self
    register_instance
    validate!              
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
      puts "Остановите поезд"
    end
  end

  def minus_wagon
    if speed == 0
      @wagon -= 1
    else
      puts "Остановите поезд"
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

  def validate!
    raise "Не верный формат номера поезда" if number !~ NUMBER_FORMAT
    raise "Тип поезда может быть только 'Грузовой' или 'Пассажирский'" if type != "Грузовой" && type != "Пассажирский"
    true 
  end

  def valide?
    validate!
  rescue
    false
  end

#перенес этот метод в секцию  protected , так как по заданию нужно было перенести какой нибудь метод
#Теперь , в моей программе, на объектах класса Train(Passenger/Cargo) нельзя вызвать метод current_station
#чтобы узнать текущую станцию. 
  protected

  def current_station
    @route.station[@index]
  end
end




