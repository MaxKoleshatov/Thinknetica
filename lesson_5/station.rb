class Station
  attr_reader :trains, :name

  @@all_station = []

  def self.all
    @@all_station
  end
    
  def initialize(name)
    @name = name
    @trains = []
    @@all_station << self
    register_instance 
  end

  def add_train(train)
    @trains << train
  end
  
  def train_by_type(type)
    @train.select {|x| puts x.type == type}
  end

  def start(train)
    @trains.delete(train)
  end
end

st_1 = Station.new("jjjj")
st_2 =Station.new("jnnnnn")
p Station.all
