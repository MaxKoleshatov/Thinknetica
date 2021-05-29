class Station
    def initialize(name)
        @name = name
        @train = []
    end


   def add_train(train)
        @train << train
   end


   def train_in_station
    @train
   end


   def train_by_type(type)
    @train.select {|x| puts x.type == type}
   end

   def start(train)
    @train.delete(train)
   end
end


class Route
    def initialize(starting_station, end_station)
        @starting_station = starting_station
        @end_station = end_station
        @intermediate_stations = []
        @station = [@starting_station, @end_station]
    end

    def add_station(name)
        @station.insert(1, name)
        @intermediate_stations << name
    end

    def delete_stations(name)
        @station.delete(name)
    end

    def station
        @station
    end
end


class Train
    def initialize(number, type, wagon)
        @speed = 0
        @number = number
        @type = type
        @wagon = wagon
    end


    def go_speed(speed)
        @speed += speed
    end


    def stop_speed(speed)
        @stop_speed -= speed
        if @speed < 0
            @speed = 0
        end
    end


    def wagon
        @wagon
    end

    def plus_wagon
        if @speed == 0
        @wagon += 1
        else
            puts "Stop train"
        end
    end

    def minus_wagon
        if speed == 0
        @wagon -= 1
        else
            puts "Stop train"
        end
    end

    def train_route(route)
        @route = route
        @index = 0
        @route.station[@index].add_train(self)
    end

    def forward_train
      
        @route.station[@index].start(self)
        @index += 1
        @route.station[@index].add_train(self)
       
        
    end


    def back_train
       
        @route.station[@index].start(self)
        @index -= 1
        @route.station[@index].add_train(self)
     
        
    end


    def next_satation
        @route.station[@index + 1]
    end


    def current_station
        @route.station[@index]
    end


    def previous_satation
        if @index > 0
        @route.station[@index - 1]
    end
end



end



