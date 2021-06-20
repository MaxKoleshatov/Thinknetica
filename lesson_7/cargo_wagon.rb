require_relative 'wagon'

class CargoWagon < Wagon

  attr_reader :type, :all_volume, :free_volume, :off_volume
       
  def initialize(volume)
    @type = "Грузовой"
    @all_volume = volume
    @free_volume = volume
    @off_volume = 0
  end

  def remove_volume(off_volume)
    @free_volume -= off_volume
    @off_volume += off_volume
  end

end

