require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'pass_wagon'
require_relative 'cargo_wagon'


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

#создаем грузовые и пассажирские вагоны и цепляем/отцепляем вовсю

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

myTrain_122.wagons_list.push(cWagon) #!!!!! почему разрешает менять @wagons_list вручную ?????????
puts "#{myTrain_122.wagons_list}"#???????
myTrain_122.add_wagon(cWagon) #???????
# myTrain_122.add_wagon(cWagon)
puts "#{myTrain_122.wagons_list}"#???????

myTrain_122.add_wagon(pWagon)
myTrain_122.unhook_wagon(pWagon)
myTrain_122.unhook_wagon(cWagon)
myTrain_122.unhook_wagon(cWagon)

myCargo = CargoTrain.new(444)
puts "#{myCargo.number}"

myPass = PassengerTrain.new(555)
puts "#{myPass.number}"

# myTrain_122.type = :pass
# puts "#{myTrain_122.type}"