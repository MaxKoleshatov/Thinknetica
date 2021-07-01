# frozen_string_literal: true

require_relative 'module_instance'
require_relative 'module_accessors'

class Station

  extend Accessors

  include InstanceCounter

  attr_accessor_with_history :trains, :name

  # strong_attr_accessor Нестал подключать в этот класс

  NAME_FORMAT = /^[а-я]{1,}$/i.freeze

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
    @train.select { |x| x.type == type }
  end

  def start(train)
    @trains.delete(train)
  end

  def validate!
    errors = []
    errors << 'Имя станции должно быть указано только русскими буквами' if name !~ NAME_FORMAT
    errors << 'Такая станция уже существует' if @@all_station.include? name
    raise errors.join('.') if errors != []
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def block_station(&block_station)
    block_station.call(trains)
  end
end
