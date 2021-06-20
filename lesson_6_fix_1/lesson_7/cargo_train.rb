class CargoTrain < Train
  
  attr_reader :route_train, :route_train, :type, :number, :speed, :wagons
  
  def initialize(number, type = "Грузовой")
    @speed = 0
    @number = number
    @type = type
    @wagons = []
    @route_train = []
    validate!
    register_instance
    @@all_train << self   
  end

  def plus_wagon(wagon)
    @wagons << wagon if @speed == 0 && wagon.class == CargoWagon  
  end

  def minus_wagon(wagon)
    @wagons.delete_at(wagon) if @speed == 0
  end

  def train_route(route)
    super
  @route_train << route
  end 
end