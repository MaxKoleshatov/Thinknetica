require_relative 'module_instance'

class Station

  include InstanceCounter

  attr_reader :trains
  attr_accessor :name

  NAME_FORMAT = /[а-я]$/i

  @@all_station = []

  def self.all
    @@all_station
  end
    
  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all_station << self.name
    register_instance 
    
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
    raise "Имя станции должно быть указано только русскими буквами" if name !~ NAME_FORMAT
    raise "Такая станция уже существует" if @@all_station.include? name
    true
  end

  def valide?
    validate!
  rescue
    false    
    end
end
