require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'pass_wagon'
require_relative 'cargo_wagon'
require_relative 'station'
require_relative 'route'


#создали паровоз произвольного назначения и играемся с ним

myTrain_122 = Train.new(122,:cargo)

puts "номер поезда - #{myTrain_122.number}"
puts "кол-во вагонов - #{myTrain_122.wagons_quantity}"
puts "скорость - #{myTrain_122.speed}"
puts "тип - #{myTrain_122.type}"
myTrain_122.accelerate
myTrain_122.brake
myTrain_122.brake
# myTrain_122.accelerate
# myTrain_122.accelerate
# myTrain_122.accelerate
# myTrain_122.accelerate
# myTrain_122.accelerate
# myTrain_122.accelerate
# myTrain_122.accelerate
# myTrain_122.accelerate
# myTrain_122.accelerate
# myTrain_122.accelerate
# myTrain_122.accelerate
# myTrain_122.accelerate

# -------------------------------------------
# создаем грузовые и пассажирские вагоны и цепляем/отцепляем вовсю
# -------------------------------------------

cWagon = CargoWagon.new(20)

puts "максимальный объем груза - #{cWagon.capacity}"
puts "свободно - #{cWagon.volume_left} ft"
puts "загружено - #{cWagon.volume_occupied} ft"
cWagon.load(4)
puts "свободно - #{cWagon.volume_left} ft"
puts "загружено - #{cWagon.volume_occupied} ft"
cWagon.unload(6)
puts "свободно - #{cWagon.volume_left} ft"
puts "загружено - #{cWagon.volume_occupied} ft"
cWagon.unload(2)
puts "свободно - #{cWagon.volume_left} ft"
puts "загружено - #{cWagon.volume_occupied} ft"
cWagon.load(19)
puts "свободно - #{cWagon.volume_left} ft"
puts "загружено - #{cWagon.volume_occupied} ft"


pWagon = PassWagon.new(2)

puts "свободно - #{pWagon.seats_left}"
puts "занято - #{pWagon.seats_occupied}"
pWagon.reserve_seat
puts "свободно - #{pWagon.seats_left}"
puts "занято - #{pWagon.seats_occupied}"
pWagon.reserve_seat
puts "занято - #{pWagon.seats_occupied}"
pWagon.reserve_seat
puts "занято - #{pWagon.seats_occupied}"
puts "свободно - #{pWagon.seats_left}"
pWagon.seat_set_free
puts "занято - #{pWagon.seats_occupied}"
puts "свободно - #{pWagon.seats_left}"
pWagon.seat_set_free
puts "занято - #{pWagon.seats_occupied}"
puts "свободно - #{pWagon.seats_left}"
pWagon.seat_set_free
puts "занято - #{pWagon.seats_occupied}"
puts "свободно - #{pWagon.seats_left}"

myTrain_122.wagons_list.push(cWagon)
puts "#{myTrain_122.wagons_list}"
myTrain_122.add_wagon(cWagon)
myTrain_122.add_wagon(cWagon)
puts "#{myTrain_122.wagons_list}"

myTrain_122.add_wagon(pWagon)
myTrain_122.unhook_wagon(pWagon)
myTrain_122.unhook_wagon(cWagon)
myTrain_122.unhook_wagon(cWagon)

# ----------------------------------
# Cargo/Pass trains check
# ----------------------------------

myCargo = CargoTrain.new(444)
puts " train # #{myCargo.number} is at the station #{myCargo.current_station.title}"

myPass = PassengerTrain.new(555)
puts "#{myPass.number}"

# myTrain_122.type = :pass
# puts "#{myTrain_122.type}"

# ------------------------------------
# Station check
# ------------------------------------
romashka = Station.new(:romashka)

my_train = Train.new(1,:cargo)
alien_train = Train.new(13,:pass)

romashka.print_trains_list
romashka.arrive(my_train)
romashka.arrive(alien_train)
romashka.print_trains_list
romashka.print_type_count
romashka.departure(my_train)
romashka.print_trains_list
romashka.print_type_count
romashka.departure(alien_train)
romashka.print_trains_list

cheburashka = Station.new(:cheburashka)
bukashka = Station.new(:bukashka)
promokashka = Station.new(:promokashka)
durashka = Station.new(:durashka)


# ----------------------------------------
# Route check
# ----------------------------------------

my_route = Route.new(romashka,cheburashka)
my_route.add_station_to_route(bukashka,romashka)#добавляем букашку после ромашки
my_route.add_station_to_route(promokashka,cheburashka)#добавление в маршрут станции после конечной
my_route.add_station_to_route(promokashka,durashka)#добавление в маршрут станции после станции, НЕвходящей в маршрут
my_route.add_station_to_route(promokashka,bukashka)#добавляем промокашку после букашки
my_route.print_stations_list
# my_route.rm_station_from_route(promokashka)
# my_route.rm_station_from_route(promokashka)
# my_route.rm_station_from_route(romashka)
# my_route.print_stations_list
# puts "#{my_route.start_station.title} became the start station"
my_route.rm_station_from_route(cheburashka)
my_route.print_stations_list

# -------------------------------------
# train <---> route check
# -------------------------------------
myTrain_122.route = my_route
puts "route for train number #{myTrain_122.number}: "
myTrain_122.route.print_stations_list
Depo.instance.print_trains_list
romashka.print_trains_list
cheburashka.print_trains_list
puts "train # #{myTrain_122.number} is at the station #{myTrain_122.current_station.title}"
puts "train # #{myCargo.number} is at the station #{myCargo.current_station.title}"
puts "train # #{myPass.number} is at the station #{myPass.current_station.title}"
puts "train # #{my_train.number} is at the station #{my_train.current_station.title}"
puts "train # #{alien_train.number} is at the station #{alien_train.current_station.title}"
puts "#{my_train.current_station.title}"
puts "route for train number #{myPass.number}: "
myPass.route.print_stations_list

# -----------------------------------------
# next/previous stations in the route check
# -----------------------------------------
myTrain_122.route.print_stations_list
puts "#{myTrain_122.current_station.title}"
puts "#{myTrain_122.previuos_station.title}"
puts "#{myTrain_122.next_station.title}"

myTrain_122.move_one_step_along_route
myTrain_122.move_one_step_along_route
myTrain_122.move_one_step_along_route
myCargo.move_one_step_along_route

# -------------------------------------
# Manufacturer
# -------------------------------------
myTrain_122.manufacturer ="Toyota"
puts myTrain_122.manufacturer
pWagon.manufacturer = "Mitsubishi"
puts pWagon.manufacturer
cWagon.manufacturer = "Щербинский вагоностроительный завод"
puts cWagon.manufacturer

# -----------------------------
# Train.find
# -----------------------------
puts Train.find(122)
puts Train.find(115)
puts Train.all_trains
# puts InstanceCounter.instances
puts Train.class_variables
puts Train.ancestors
# puts Train.instances

# -----------------------------
# validate! train
# -----------------------------
valid_train = Train.new("aas-12", :cargo)
puts valid_train.validate!
unvalid_number_train = Train.new("aa", :pass)
# puts unvalid_number_train.validate!
unvalid_type_train = Train.new("aaw-11", :pa)
# puts unvalid_type_train.validate!
invalid_number_cargotrain = CargoTrain.new("ss")
# puts invalid_number_cargotrain.validate!

# -----------------------------
# valid? train
# -----------------------------
puts valid_train.valid?
puts unvalid_number_train.valid?
puts unvalid_type_train.valid?
puts invalid_number_cargotrain.valid?

# -----------------------------

# -----------------------------
valid_station = Station.new("nizhnie kozly")
unvalid_station = Station.new("dhfj ((")
# puts unvalid_station.validate!
puts "Проверка valid?"
# -----------------------------
# valid? station
# -----------------------------
puts valid_station.valid?
puts unvalid_station.valid?
puts myCargo.valid?
puts myPass.valid?
# puts myPass.validate!
myPass.manufacturer = "Toyota"
puts myPass.manufacturer
puts valid_train.validate!
puts cWagon.capacity.to_i.class
puts cWagon.validate!
#--------------------------------
testWagon = CargoWagon.new(20)
# testWagon.capacity = nil
# puts testWagon.capacity.class
# puts testWagon.validate!
#-------------------------------
testWagon = PassWagon.new(24)
# testWagon.seats_max = nil
puts testWagon.seats_max.class
# puts testWagon.validate!
#-------------------------------
puts "----"
testRoute = Route.new(romashka, Depo.instance)
puts testRoute.valid?
puts testRoute.validate!

# a = Station.new("aaa")
# puts a.is_a?(Depo)
# puts Depo.instance.is_a?(Station)