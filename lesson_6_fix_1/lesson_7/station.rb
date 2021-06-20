require_relative 'module_instance'

class Station

  include InstanceCounter

  attr_reader :trains, :name
  
  NAME_FORMAT = /^[а-я]{1,}$/i

  @@all_station = []

  def self.all
    @@all_station
  end
    
  def initialize(name)
    @name = name
    validate!
    register_instance 
    @trains = []
    @@all_station << self.name   
  end

  def add_train(train)
    @trains << train
  end
  
  def train_by_type(type)
    @train.select {|x| x.type == type}
  end

  def start(train)
    @trains.delete(train)
  end

  def validate!
    errors = []
    errors << "Имя станции должно быть указано только русскими буквами" if name !~ NAME_FORMAT
    errors << "Такая станция уже существует" if @@all_station.include? name
    raise errors.join(".") if errors != []
  end

  def valid?
    validate!
  rescue
    false
  end

  def block_station(&block_station)
    block_station.call(trains)
  end
end

