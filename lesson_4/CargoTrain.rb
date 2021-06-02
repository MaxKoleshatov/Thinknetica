class CargoTrain < Train
    def initialize(number, type)
        @speed = 0
        @number = number
        @type = type
        @wagon = []
    end

    
    def plus_wagon(wagon)
        if @speed == 0 && wagon.class == CargoWagon
        @wagon << wagon
        else
            puts "Stop train or change the type of wagon"
        end
    end
end