class CargoWagon

# Максимальный объем груза 
# Метод загрузки. Указывается объем загружаемого груза, при этом, свободный объем уменьшается на указанную величину. Нельзя загрузить в вагон объем больше, чем максимальный.
# Метод выгрузки (указывается объем). Кол-во свободного объема увеличивается на указанную величину.
# Может возвращать оставшийся свободный объем
# Может возвращать занятый объем

	attr_reader :capacity, :volume_occupied, :type
	attr_accessor :hooked

	def initialize(capacity)
		@capacity = capacity
		@volume_occupied = 0
		@type = :cargo
		@hooked = false
	end

#возвращает доступный для погрзки объем
	def volume_left
		@capacity - @volume_occupied
	end

#ззагрузить объем груза = cargo
	def load (cargo)
		@volume_occupied = @volume_occupied + cargo < @capacity ? @volume_occupied + cargo : @volume_occupied
	end

#выгрузить объем груза = cargo
	def unload (cargo)
		@volume_occupied = @volume_occupied > cargo ? @volume_occupied - cargo : @volume_occupied
	end

# установка флага "прицеплен"
	def set_hooked
		@hooked = true
	end
# установка флага "отцеплен"
	def set_unhooked
		@hooked = false
	end

	private

	attr_writer :volume_occupied

end

# cWagon = CargoWagon.new(20)

# puts "максимальный объем груза - #{cWagon.capacity}"
# puts "свободно - #{cWagon.volume_left} ft"
# puts "загружено - #{cWagon.volume_occupied} ft"
# cWagon.load(4)
# puts "свободно - #{cWagon.volume_left} ft"
# puts "загружено - #{cWagon.volume_occupied} ft"
# cWagon.unload(6)
# puts "свободно - #{cWagon.volume_left} ft"
# puts "загружено - #{cWagon.volume_occupied} ft"
# cWagon.unload(2)
# puts "свободно - #{cWagon.volume_left} ft"
# puts "загружено - #{cWagon.volume_occupied} ft"
# cWagon.load(19)
# puts "свободно - #{cWagon.volume_left} ft"
# puts "загружено - #{cWagon.volume_occupied} ft"