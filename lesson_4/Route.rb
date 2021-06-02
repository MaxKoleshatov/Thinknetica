class Route

    attr_reader :stations

    def initialize(starting_station, end_station)
        @starting_station = starting_station
        @end_station = end_station
        @intermediate_stations = []
        @stations = [@starting_station, @end_station]
    end

    def add_station(name)
        @stations.insert(1, name)
        @intermediate_stations << name
    end

    def delete_stations(name)
        @stations.delete(name)
        @intermediate_stations.delete(name)
    end

 
end
