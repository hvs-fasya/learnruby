class Train

	attr_reader :number, :type
	attr_accessor :wagons, :speed

	def initialize(number,type,wagons,speed = 0)
		@number = number
		@type = type
		@wagons = wagons
		@speed = speed
	end

	def print_speed
		puts "скорость: #{@speed}"
	end

	def print_wagons
		puts "кол-во вагонов: #{@wagons}"
	end

	def print_type
		puts "тип: #{@type}"
	end

	def print_number
		puts "номер: #{@number}"
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

	def more_wagon
		if @speed == 0
			@wagons = @wagons + 1
			puts "прицепили вагон - теперь #{@wagons} вагона(ов)"
		else
			puts "не вышло прицепить вагон"
		end
	end

	def less_wagon
		if @speed == 0 && @wagons > 0
			@wagons = @wagons - 1
			puts "отцепили вагон - теперь #{@wagons} вагона(ов)"
		else
			puts "не вышло отцепить вагон"
		end
	end
end

class Station

	attr_reader :title
	attr_accessor :trains_list

	def initialize(title, trains_list = [])
		@title = title
		@trains_list = trains_list
	end

	def arrive(train)
		@trains_list.push(train)
		puts "welcome паровоз № #{train.number}"
	end

	def departure (train)
		if @trains_list.include?(train)
			@trains_list.delete(train)
			puts "buy паровоз № #{train.number}"
		else
			puts "нет у нас такого паровоза"
		end
	end

	def print_list
		if @trains_list.empty?
			puts "у нас нет ни одного паровоза"
		else
			@trains_list.each { |train|  train.print_number}
		end
	end

end

my_train = Train.new(1,:cargo,4)

my_train.print_speed
my_train.print_wagons
my_train.print_number
my_train.print_type
my_train.accelerate
my_train.brake
my_train.brake
my_train.accelerate
my_train.more_wagon
my_train.less_wagon
my_train.brake
my_train.more_wagon
my_train.less_wagon

romashka = Station.new(:romashka)

romashka.print_list
romashka.arrive(my_train)
romashka.print_list
romashka.departure(my_train)
romashka.print_list