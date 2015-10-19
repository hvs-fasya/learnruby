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
puts Train.validation_rules
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
# puts "-------"
# Train.validate :current_station, :presence
# Train.validate :current_station, :type, Station
# puts Train.current_station_rules
# puts Train.validation_methods
# puts "-------"
# puts myTrain_122.valid?
# puts myTrain_122.valid?
puts "-------"
# Train.validate :number, :presence
# Train.validate :number, :format, "/[a-z0-9]{3}-?[a-z0-9]{2}/i"
# Train.validate :current_station, :type, Station
# Train.validate :route, :type, Route
# puts Train.number_presence
# puts Train.number_format
puts Train.validation_rules
# puts Train.number_presence
# myTrain_122.number = nil
# puts Train.number_format
# puts myTrain_122.validate!
# puts Train.instance_methods
# puts myTrain_122.number_presence
# puts myTrain_122.number_format
# puts myCargo.number_format
myCargoWrong = CargoTrain.new("333-33")
# puts myCargoWrong.validate!
# puts myCargoWrong.valid?
myCargoWrong.current_station = myTrain_122
# puts myCargoWrong.current_station
puts myCargoWrong.valid?
romashka.arrive(myCargoWrong)
puts myCargoWrong.valid?
# myCargoWrong.route = myTrain_122
# puts myCargoWrong.valid?
cheburashka = Station.new("aaa")
myRoute = Route.new(romashka,cheburashka)
# myCargoWrong.route = myRoute
# puts myCargoWrong.valid?