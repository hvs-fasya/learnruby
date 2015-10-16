require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'pass_wagon'
require_relative 'cargo_wagon'
require_relative 'station'
require_relative 'route'

myTrain_122 = Train.new("122-aa",:pass)
romashka = Station.new(:romashka)
romashka.arrive(myTrain_122)

myCargo = CargoTrain.new("444-cc")
myCargo.add_wagon(CargoWagon.new(20))
myCargo.add_wagon(CargoWagon.new(14))
myCargo.add_wagon(CargoWagon.new(25))
romashka.arrive(myCargo)

# romashka.all_trains_info

romashka.print_all_trains_info

myCargo.call_for_each_wagon {|wagon| puts wagon.capacity}

begin
	myTrain_122.type = :cargo
	myTrain_122.type = "cargo"
rescue ArgumentError => e
	puts e.message
end
myTrain_122.type = :pass
begin
	myTrain_122.type = 5
rescue ArgumentError => e
	puts e.message
end