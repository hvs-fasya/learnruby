require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'pass_wagon'
require_relative 'cargo_wagon'
require_relative 'station'
require_relative 'route'

myTrain_122 = Train.new("122-aa",:pass)
puts "------"
romashka = Station.new(:romashka)
romashka.arrive(myTrain_122)
myCargo = CargoTrain.new("444-cc")
romashka.arrive(myCargo)
