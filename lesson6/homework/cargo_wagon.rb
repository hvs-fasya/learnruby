require_relative 'manufacturer'

class CargoWagon

# Максимальный объем груза 
# Метод загрузки. Указывается объем загружаемого груза, при этом, свободный объем уменьшается на указанную величину. Нельзя загрузить в вагон объем больше, чем максимальный.
# Метод выгрузки (указывается объем). Кол-во свободного объема увеличивается на указанную величину.
# Может возвращать оставшийся свободный объем
# Может возвращать занятый объем

	attr_reader :capacity, :volume_occupied, :type
	attr_accessor :hooked
	# attr_writer :capacity

	include Manufacturer

	def initialize(capacity)
		@capacity = capacity
		@volume_occupied = 0
		@type = :cargo
		@hooked = false
		validate!
	end

	def validate!
		# raise ArgumentError, "не задана вместимость грузового вагона" if @capacity.nil?
		raise ArgumentError, "вмсетимость грузового вагона должна быть числом и желательно целым" if @capacity.class != Fixnum
		raise ArgumentError, "вмсетимость грузового вагона должна больше нуля и меньше 1000" if 0 >= @capacity || @capacity >= 1000
		true
	end

	def valid?
			self.validate!
		rescue ArgumentError
			false
	end

#возвращает доступный для погрзки объем
	def volume_left
		@capacity - @volume_occupied
	end

#ззагрузить объем груза = cargo
	def load (cargo)
		@volume_occupied = @volume_occupied + cargo <= @capacity ? @volume_occupied + cargo : @volume_occupied
	end

#выгрузить объем груза = cargo
	def unload (cargo)
		@volume_occupied = @volume_occupied >= cargo ? @volume_occupied - cargo : @volume_occupied
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
