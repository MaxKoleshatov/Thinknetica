# frozen_string_literal: true

require_relative 'wagon'

class CargoWagon < Wagon
  
  attr_accessor_with_history :type, :all_volume, :free_volume, :off_volume
  strong_attr_accessor :type, String

  validate :all_volume, :presence
  validate :all_volume, :format
  validate :all_volume, :type, Integer

  def initialize(volume)
    super
    @type = 'Грузовой'
    @all_volume = volume
    @free_volume = volume
    @off_volume = 0
    validate!
  end

  def remove_volume(off_volume)
    @free_volume -= off_volume
    @off_volume += off_volume
  end
end

