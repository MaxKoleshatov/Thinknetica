class CargoTrain < Train
  
  attr_reader :route_train
  attr_accessor :type, :number

  def initialize(number, type = "cargo")
    @speed = 0
    @number = number
    @type = type
    @wagon = []
    @route_train = []
    @@all_train << self
    register_instance 
    validate!
    
  end

  def plus_wagon(wagon)
    if @speed == 0 && wagon.class == CargoWagon
      @wagon << wagon
    else
      puts "Остановите поезд или поменяйте тип вагона"
    end
  end

  def minus_wagon(wagon)
    if @speed == 0
      @wagon.delete_at(wagon)
    else
      puts "Остановите поезд"
    end
  end

  def train_route(route)
    super
    @route_train << route
  end 
end