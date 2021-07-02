# frozen_string_literal: true

require_relative 'train'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'station'
require_relative 'route'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

@stations_user_all = []
@trains_user_all = []
@routes_user_all = []

OPTIONS = {
  1 => "создать станцию",
  2 => "создать поезд",
  3 => "создать маршрут поезду",
  4 => "добавить станцию в маршрут",
  5 => "удалить станцию из маршрута",
  6 => "назначить маршрут поезду",
  7 => "прицепить вагон к поезду",
  8 => "отцепить вагон от поезда",
  9 => "переместить поезд вперед по маршруту",
  10 => " переместить поезд назад по маршруту",
  11 => "посмотреть список станций",
  12 => "посмотреть список поездов на станции",
  13 => "посмотреть список вагонов у поезда",
  14 => "занять место в вагоне",
  0 => "выйти из программы",
}

def menu 
  puts "Выберите доступную опцию:"
  OPTIONS.each {|num, text| puts "#{num} - #{text}"}
  number = gets.chomp.to_i
  start_program(number)
end

def start_program(number)
  actions = { 1 => :create_station, 2 => :create_train, 3 => :create_route, 4 => :add_station_route,
              5 => :delete_station_rout, 6 => :add_route_train, 7 => :add_wagon_train, 8 => :delete_wagon_train,
              9 => :forward_train, 10 => :back_train, 11 => :stations_user_all, 12 => :train_in_station,
              13 => :list_wagons, 14 => :s_seat, 0 => :finish_programm }

  send actions[number]
end

def create_station
  puts "Вы выбрали 'Создать станцию'. Для этого введите название станции:"
  name = gets.chomp
  station_user = Station.new(name)
  @stations_user_all << station_user if station_user
  menu
rescue StandardError => e
  puts "#{e.message}. Попробуйте снова создать станцию."
  retry
end

def method_support_ct
  puts 'Укажите тип поезда какой хотите создать:  1 - Пассажирский  2- Грузовой'
  @type = gets.chomp.to_i
  puts 'Поезд может быть только Грузовым или Пассажирским. Попробуйте еще раз' if @type < 1 || @type > 2
  menu if @type < 1 || @type > 2
end

def create_train
  method_support_ct
  puts 'введите номер поезда'
  number_train = gets.chomp
  train_user = PassengerTrain.new(number: number_train, type: 'Пассажирский') if @type == 1
  train_user = CargoTrain.new(number: number_train, type: 'Грузовой') if @type == 2
  puts "Вы создали поезд № #{train_user.number}"
  @trains_user_all << train_user
  menu
rescue StandardError => e
  puts "#{e.message}. Попробуйте снова создать поезд "
end

def method_support_one_cr
  puts "Вы выбрали 'Создать маршрут поезду'. Для этого введите
  начальную станцию маршрута:"
  @starting_name = gets.chomp
  puts 'конечную станцию маршрута:'
  @end_name = gets.chomp
end

def method_support_two_cr
  @starting_station = Station.new(@starting_name)
  @stations_user_all << @starting_station if @starting_station
  @end_station = Station.new(@end_name)
  @stations_user_all << @end_station if @end_station
end

def create_route
  method_support_one_cr
  method_support_two_cr
  route_user = Route.new(starting_station: @starting_station, end_station: @end_station)
  @routes_user_all << route_user
  menu
rescue StandardError => e
  puts "#{e.message}. Попробуйте снова создать маршрут."
  retry
end

def method_support_asr
  if @routes_user_all != []
    puts "Вы выбрали 'Добавить станцию в маршрут'. Для этого выберите маршрут в который хотите добавить станцию:"
    @routes_user_all.each_with_index { |routes, index| puts "#{index} : #{routes}" }
    @index_user_route = gets.chomp.to_i
  else
    puts 'Сначало создайте маршрут поезда'
    menu
  end
end

def add_station_route
  method_support_asr
  puts 'Введите название станции какую хотите добавить'
  name = gets.chomp
  user_station = Station.new(name)
  @stations_user_all << user_station
  @routes_user_all[@index_user_route].add_station(user_station)
  menu
rescue StandardError => e
  puts "#{e.message}. Попробуйте снова"
end

def method_support_one_dsr
  if @routes_user_all != []
    puts 'Выберите маршрут из которого хотите удалить станцию'
    @routes_user_all.each_with_index { |routes, index| puts "#{index} : #{routes}" }
    @index_user_route = gets.chomp.to_i
  else
    puts 'Сначало создайте маршрут поезда'
    menu
  end
end

def method_support_two_dsr
  if @routes_user_all[@index_user_route].intermediate_stations != []
    puts 'Выберите станцию которую хотите удалить:'
    @routes_user_all[@index_user_route].intermediate_stations.each_with_index do |stations, index|
      puts "#{index} : #{stations.name}"
    end
  else
    puts 'Нет станций которые можно удалить из  маршрута!'
    menu
  end
end

def delete_station_rout
  method_support_one_dsr
  method_support_two_dsr
  index_user_station = gets.chomp.to_i
  @routes_user_all[@index_user_route].delete_stations(index_user_station)
  menu
end

def method_support_one_art
  if @trains_user_all != []
    puts "Вы выбрали 'Назначить маршрут поезу'. Для этого выберите поезд которому хотите назначить маршрут:"
    @trains_user_all.each_with_index do |trains, index|
      puts "#{index} : #{trains}"
    end
  else
    puts 'Сначалa создайте поезд!'
    menu
  end
end

def method_support_two_art
  @index_user_train = gets.chomp.to_i
  if @routes_user_all != []
    puts 'Выберите маршрут который хотите добавить:'
    @routes_user_all.each_with_index do |routes, index|
      puts "#{index} : #{routes}"
    end
  else
    puts 'Нет маршрута который можно добавить. Создайте маршрут!'
    menu
  end
end

def add_route_train
  method_support_one_art
  method_support_two_art
  index_user_route = gets.chomp.to_i
  @trains_user_all[@index_user_train].train_route(@routes_user_all[index_user_route])
  menu
end

def method_support_one_awt
  if @trains_user_all != []
    puts "Вы выбрали 'прицепить вагон к поезду'. Для этого выберите тип вагона какой хотите прицепить:
    1 - Пассажирский 2 - Грузовой"
    @type_wagon = gets.chomp.to_i
    puts 'Для пассажирского вагона задайте количество мест' if @type_wagon == 1
    puts 'Для грузового вагона задайте обьем вагона' if @type_wagon == 2
  else
    puts 'Нет поезда к которому можно прицепить вагон. Создайте поезд!'
    menu
  end
end

def method_support_two_awt
  params = gets.chomp.to_i
  @wagon_user = PassengerWagon.new(params) if @type_wagon == 1
  @wagon_user = CargoWagon.new(params) if @type_wagon == 2
  puts 'Выберите поезд к которому хотите прицепить вагон'
  @trains_user_all.each_with_index do |trains, index|
    print index
    print ': '
    puts trains
  end
end

def add_wagon_train
  method_support_one_awt
  method_support_two_awt
  index_user_train = gets.chomp.to_i
  if @trains_user_all[index_user_train].type == @wagon_user.type
    @trains_user_all[index_user_train].plus_wagon(@wagon_user)
  end
  puts 'Остановите поезд или поменяйте тип вагона' if @trains_user_all[index_user_train].type != @wagon_user.type
  menu
end

def method_support_one_dwt
  if @trains_user_all != []
    puts 'Выберите поезд от которого хотите отцепить вагон'
    @trains_user_all.each_with_index do |trains, index|
      puts "#{index} : #{trains}"
    end
  else
    puts 'Нет поезда от которого можно отцепить вагон. Создайте поезд!'
    menu
  end
end

def method_support_two_dwt
  @index_user_train = gets.chomp.to_i
  if @trains_user_all[@index_user_train].wagons != []
    puts 'Выберите вагон который хотите отцепить'
    @trains_user_all[@index_user_train].wagons.each_with_index do |wagon, index|
      puts "#{index} : #{wagon}"
    end
  else
    puts 'У этого поезда нет вагонов'
    menu
  end
end

def delete_wagon_train
  method_support_one_dwt
  method_support_two_dwt
  index_user_wagon = gets.chomp.to_i
  @trains_user_all[@index_user_train].minus_wagon(index_user_wagon) if @trains_user_all[@index_user_train].speed.zero?
  puts 'Остановите поезд' if @trains_user_all[@index_user_train].speed != 0
  menu
end

def method_support_ft
  if @trains_user_all != []
    puts "Вы выбрали 'Переместить поезд вперед по маршруту'. Для этого выберите поезд который хотите продвинуть:"
    @trains_user_all.each_with_index do |trains, index|
      puts "#{index} : #{trains}"
    end
  else
    puts 'Сначалa создайте поезд!'
    menu
  end
end

def forward_train
  method_support_ft
  index_user_train = gets.chomp.to_i
  if @trains_user_all[index_user_train].route_train != []
    @trains_user_all[index_user_train].forward_train
  else
    puts 'У поезда нет маршрута! Присвойте маршрут'
  end
  menu
end

def method_support_bt
  if @trains_user_all != []
    puts "Вы выбрали 'Переместить поезд назад по маршруту'. Для этого выберите поезд который хотите переместить:"
    @trains_user_all.each_with_index do |trains, index|
      puts "#{index} : #{trains}"
    end
  else
    puts 'Сначалa создайте поезд!'
    menu
  end
end

def back_train
  method_support_bt
  index_user_train = gets.chomp.to_i
  if @trains_user_all[index_user_train].route_train != []
    @trains_user_all[index_user_train].back_train
  else
    puts 'У поезда нет маршрута! Присвойте маршрут'
  end
  menu
end

def stations_user_all
  if @stations_user_all != []
    @stations_user_all.each_with_index do |station, index|
      puts "#{index} - #{station.name}"
    end
  else
    puts 'Нет ни одной станции'
  end
  menu
end

def method_support_one_tis
  if @stations_user_all != []
    puts 'Выберите станцию у которой хотите посмотреть список поездов:'
    @stations_user_all.each_with_index do |station, index|
      puts "#{index} - #{station}"
    end
    @index_user_station = gets.chomp.to_i
  else
    puts 'Нет ни одной станции. Создайте станцию.'
    menu
  end
end

def method_support_two_tis
  if @stations_user_all[@index_user_station].trains != []
    block_station = proc { |all_trains|
      all_trains.each do |train|
        puts "Номер поезда - #{train.number} , Тип поезда - #{train.type} , Количество вагонов - #{train.wagons.length}"
      end
    }
    @stations_user_all[@index_user_station].block_station(&block_station)
  else
    puts 'На станции нет поездов'
  end
end

def train_in_station
  method_support_one_tis
  method_support_two_tis
  menu
end

def method_support_one_lw
  if @trains_user_all != []
    puts 'Выберите поезд у которго хотите посмотреть спиcок вагонов:'
    @trains_user_all.each_with_index do |trains, index|
      puts "#{index} - #{trains}"
    end
    @index_user_train = gets.chomp.to_i
  else
    puts 'Нет поезда у которого можно посмотреть вагоны'
    menu
  end
end

def method_support_two_lw
  if @trains_user_all[@index_user_train].wagons != []
    @num = 0
  else
    puts 'У поезда нет вагонов! Добавьте вагоны'
    menu
  end
end

def method_support_three_lw
  return unless @trains_user_all[@index_user_train].type == 'Пассажирский'

  block_train = proc { |wagons|
    wagons.each do |wagon|
      puts "Номер вагона № #{@num += 1}, Тип вагона - #{wagon.type} , Кол.сво-ых мест - #{wagon.free_passenger_seat}," \
           "Количество занятых мест -#{wagon.off_passenger_seat}"
    end
  }
  @trains_user_all[@index_user_train].block_train(&block_train)
end

def method_support_four_lw
  return unless @trains_user_all[@index_user_train].type == 'Грузовой'

  block_train = proc { |wagons|
    wagons.each do |wagon|
      puts "Номер вагона № #{@num += 1}," \
           "Тип вагона - #{wagon.type} , Количество свободного обьема - #{wagon.free_volume}," \
           "Количество занятого обьема -#{wagon.off_volume}"
    end
  }
  @trains_user_all[@index_user_train].block_train(&block_train)
end

def list_wagons
  method_support_one_lw
  method_support_two_lw
  method_support_three_lw
  method_support_four_lw
  menu
end

def method_support_one_ss
  if @trains_user_all != []
    puts 'Выберите поезд в вагоне которого хотите занять место:'
    @trains_user_all.each_with_index do |trains, index|
      puts "#{index} - #{trains}"
    end
    @index_user_train = gets.chomp.to_i
  else
    puts 'Нет поезда в вагоне которого можно занять место'
    menu
  end
end

def method_support_two_ss
  if @trains_user_all[@index_user_train].wagons != []
    puts 'Выберите вагон в котором хотите занять место:'
    @trains_user_all[@index_user_train].wagons.each_with_index do |wagon, index|
      puts "#{index} - #{wagon}"
    end
    @index_user_wagon = gets.chomp.to_i
  else
    puts 'У поезда нет вагонов'
    menu
  end
end

def method_support_three_ss
  return unless @trains_user_all[@index_user_train].type == 'Пассажирский'

  @trains_user_all[@index_user_train].wagons[@index_user_wagon].remove_place
end

def method_support_four_ss
  return unless @trains_user_all[@index_user_train].type == 'Грузовой'

  puts 'Введите количество обьема которое хотите занять:'
  off_volume = gets.chomp.to_i
  @trains_user_all[@index_user_train].wagons[@index_user_wagon].remove_volume(off_volume)
end

def s_seat
  method_support_one_ss
  method_support_two_ss
  method_support_three_ss
  method_support_four_ss
  menu
end

def finish_programm
  exit
end

menu
