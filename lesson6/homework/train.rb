require_relative 'pass_wagon'
require_relative 'cargo_wagon'
require_relative 'route'
require_relative 'station'
require_relative 'depo'
require_relative 'route'
require_relative 'nowhere'

class Train

	attr_reader :number, :type, :speed, :route
	attr_accessor :current_station

	def initialize(number,type)
		@number = number
		@type = type
		@wagons_list = []
		@speed = 0
		@route = Nowhere.instance
		@current_station = Depo.instance
		Depo.instance.arrive(self)
	end

	def wagons_list
		@wagons_list.clone
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

	def route=(route)
		route.start_station.arrive(self)
		@route = route
	end

	def previuos_station
		num = @route.get_full_stations_list.index(@current_station)
		num.zero? ? @route.get_full_stations_list[0] : @route.get_full_stations_list[num-1]
	end

	def next_station
		num = @route.get_full_stations_list.index(@current_station)
		@current_station == @route.last_station ? @route.last_station : @route.get_full_stations_list[num+1]
	end

	def move_one_step_along_route
		aim = self.next_station
		if aim == @current_station
			puts "никуда не едем - мы на конечной; если уж так неймется ехать - смените маршрут и езжайте на здоровье"
		else
			@current_station.departure(self)
			aim.arrive(self)
		end
	end

	protected

	attr_writer :speed

end