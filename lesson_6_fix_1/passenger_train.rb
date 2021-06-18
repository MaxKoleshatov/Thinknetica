class PassengerTrain < Train

  attr_reader :route_train, :type, :number, :speed

  def initialize(number, type = "Пассажирский")
    @speed = 0
    @number = number
    @type = type
    @wagon = []
    @route_train = []
    validate!
    register_instance
    @@all_train << self
  end
        
  def plus_wagon(wagon)
    @wagon << wagon if @speed == 0 && wagon.class == PassengerWagon
  end
    
  def minus_wagon(wagon)
    @wagon.delete_at(wagon) if @speed == 0
  end

  def train_route(route)
    super
  @route_train << route
  end 
end





