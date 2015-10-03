require_relative 'pass_wagon'
require_relative 'cargo_wagon'

class Train

	attr_reader :number, :type, :speed, :wagons_list

	def initialize(number,type)
		@number = number
		@type = type
		@wagons_list = []
		@speed = 0
	end

	def wagons_quantity
		@wagons_list.count
	end

	def brake
		if @speed >= 10
			@speed = @speed - 10
			puts "тормознули: скорость - #{@speed}"
		else
			puts "тормознуть не вышло: скорость осталась - #{@speed}"
		end
	end

	def accelerate
		if @speed <= 100 
			@speed  = @speed + 10
			puts "ускорились: скорость - #{@speed}"
		else
			@speed = @speed
			puts "ускориться не вышло: скорость осталась - #{@speed}"
		end
	end

	def add_wagon (wagon)
		if @speed == 0 && wagon.type === self.type && wagon.hooked === false
			@wagons_list.push(wagon)
			wagon.set_hooked
			puts "прицепили вагон - теперь #{self.wagons_quantity} вагона(ов)"
		else
			puts "не вышло прицепить вагон"
		end
	end

	def unhook_wagon (wagon)
		if @speed == 0 && @wagons_list.include?(wagon)
			@wagons_list.delete(wagon)
			wagon.set_unhooked
			puts "отцепили вагон - теперь #{self.wagons_quantity} вагона(ов)"
		else
			puts "не вышло отцепить вагон"
		end
	end

	protected

	attr_writer :speed, :wagons_list

end