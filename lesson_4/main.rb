

require_relative 'Train'
require_relative 'CargoWagon'
require_relative 'PassengerTrain'
require_relative 'CargoTrain'
require_relative 'Station'
require_relative 'Route'
require_relative 'PassengerWagon'
stations_user_all = []
trains_user_all = []
routes_user_all = []



loop do
puts "Выберите доступную опцию:

1-создать станцию
2-создать поезд
3-создать маршрут поезду
4-добавить станцию в маршрут
5-удалить станцию из маршрута
6-назначить маршрут поезду
7-прицепить вагон к поезду
8-отцепить вагон от поезда
9-переместить поезд вперед по маршруту
10- переместить поезд назад по маршруту
11-посмотреть список станций
12-посмотреть список поездов на станции 
0-выйти из программы"



number = gets.chomp.to_i

if number == 0
  break
end

if number == 1
  puts "Вы выбрали 'Создать станцию'. Для этого введите название станции:"
     name = gets.chomp
     station_user = Station.new(name)
     stations_user_all << station_user
  

  elsif number == 2
      puts "Вы выбрали 'Создать поезд'. Для этого выберите тип поезда какой хотите создать:
      1 - Пассажирский
      2- Грузовой"
      type_train = gets.chomp.to_i
      puts "введите номер поезда"
      number_train = gets.chomp
          
      train_user = PassengerTrain.new(number_train, type_train = "Passenger") if type_train == 1
      train_user = CargoTrain.new(number_train, type_train = "Cargo") if type_train == 2
      trains_user_all << train_user
  

  elsif number == 3
      puts "Вы выбрали 'Создать маршрут поезду'. Для этого введите
      начальную станцию маршрута:"
      starting_station_user = gets.chomp
      starting_station = Station.new(starting_station_user)
      stations_user_all << starting_station
      puts "конечную станцию маршрута:"
      end_station_user = gets.chomp
      end_station = Station.new(end_station_user)
      stations_user_all << end_station
      route_user = Route.new(starting_station, end_station)
      routes_user_all << route_user


    elsif number == 4
      if routes_user_all != []
      puts "Вы выбрали 'Добавить станцию в маршрут'. Для этого выберите маршрут в который хотите добавить станцию:"
      routes_user_all.each_with_index do |x, index|
      print index
      print ": "
      print x.stations
      end
      
      index_user_route = gets.chomp.to_i

      if stations_user_all != []
      puts "Выберите станцию которую хотите добавить:"
      stations_user_all.each_with_index do |x, index|
        print index
        print ": "
        puts x.name
      end
    
      index_user_station = gets.chomp.to_i
  
      routes_user_all[index_user_route].add_station(stations_user_all[index_user_station])

      else puts "Нет станций которые можно добавить"
      end
      
      else puts "Сначало создайте маршрут поезда"
      end


    elsif number == 5
      if routes_user_all != [] 
        puts "Вы выбрали 'Удалить станцию из маршрута'. Для этого выберите номер маршрута из которого хотите удалить станцию:"
          routes_user_all.each_with_index do |x, index|
          print index
          print ": "
          puts x.stations
      end

        index_user_route = gets.chomp.to_i

      if stations_user_all != []
          puts "Выберите станцию которую хотите удалить:"
          stations_user_all.each_with_index do |x, index|
            print index
            print ": "
            puts x.name
      end
        
          index_user_station = gets.chomp.to_i

          routes_user_all[index_user_route].delete_stations(stations_user_all[index_user_station])
        else puts "Нет станций которые можно удалить из  маршрута!"
        end

        else puts "Сначалa создайте маршрут поезда!"
        end


        elsif number == 6
          if trains_user_all != [] 
          puts "Вы выбрали 'Назначить маршрут поезу'. Для этого выберите поезд которому хотите назначить маршрут:"
          trains_user_all.each_with_index do |x, index|
            print index
            print ": "
            puts x
          end
        
          index_user_train = gets.chomp.to_i

          if routes_user_all != []
            puts "Выберите маршрут который хотите добавить:"
            routes_user_all.each_with_index do |x, index|
              print index
              print ": "
              puts x
            end
          
            index_user_route = gets.chomp.to_i

            trains_user_all[index_user_train].train_route(routes_user_all[index_user_route])

          else puts "Нет маршрута который можно добавить. Создайте маршрут!"

          end
  
          else puts "Сначалa создайте поезд!"

          end


        elsif number == 7
          puts "Вы выбрали 'прицепить вагон к поезду'. Для этого выберите тип вагона какой хотите прицепить:
          1 - Пассажирский
          2 - Грузовой"
          type_wagon = gets.chomp.to_i
          wagon_user = PassengerWagon.new if type_wagon == 1
          wagon_user = CargoWagon.new if type_wagon == 2 
          if trains_user_all != []
           puts "Выберите поезд к которому хотите прицепить вагон"
           trains_user_all.each_with_index do |x, index|
            print index
            print ": "
            puts x
          end
        
          index_user_train = gets.chomp.to_i

          trains_user_all[index_user_train].plus_wagon(wagon_user)

        else puts "Нет поезда к которому можно прицепить вагон. Создайте поезд!"
        end


        elsif number == 8
           if trains_user_all != []
           puts "Выберите поезд от которого хотите отцепить вагон"
           trains_user_all.each_with_index do |x, index|
            print index
            print ": "
            puts x
          end
        
          index_user_train = gets.chomp.to_i

          trains_user_all[index_user_train].minus_wagon(wagon_user)

        else puts "Нет поезда от которого можно отцепить вагон. Создайте поезд!"
        end


      elsif number == 9
        if trains_user_all != [] 
          puts "Вы выбрали 'Переместить поезд вперед по маршруту'. Для этого выберите поезд который хотите продвинуть:"
          trains_user_all.each_with_index do |x, index|
            print index
            print ": "
            puts x
          end
        
          index_user_train = gets.chomp.to_i

          if routes_user_all != []
            puts "Выберите маршрут по которому хотите передвинуть поезд:"
            routes_user_all.each_with_index do |x, index|
              print index
              print ": "
              puts x
            end
          
            index_user_route = gets.chomp.to_i

             trains_user_all[index_user_train].train_route(routes_user_all[index_user_route])
             trains_user_all[index_user_train].forward_train

          else puts "Нет маршрута который можно добавить. Создайте маршрут!"

          end

          else puts "Сначалa создайте поезд!"

          end


        elsif number == 10
          if trains_user_all != [] 
            puts "Вы выбрали 'Переместить поезд назад по маршруту'. Для этого выберите поезд который хотите переместить:"
            trains_user_all.each_with_index do |x, index|
              print index
              print ": "
              puts x
            end
          
            index_user_train = gets.chomp.to_i
  
            if routes_user_all != []
              puts "Выберите маршрут по которому хотите переместить поезд:"
              routes_user_all.each_with_index do |x, index|
                print index
                print ": "
                puts x
              end
            
              index_user_route = gets.chomp.to_i
  
               trains_user_all[index_user_train].train_route(routes_user_all[index_user_route])
               trains_user_all[index_user_train].back_train
  
            else puts "Нет маршрута который можно добавить. Создайте маршрут!"
  
            end
  
            else puts "Сначалa создайте поезд!"
  
            end

          elsif number == 11
            if stations_user_all != []
              stations_user_all.each {|x| puts x.name}
            else puts "Нет ни одной станции"
            end

          elsif number == 12
            if stations_user_all != []
              stations_user_all.each {|x| puts "#{x.name}" => "#{x.trains}"} 
            else puts "Нет ни одной станции"
            end


        
      end

    end
  



      




