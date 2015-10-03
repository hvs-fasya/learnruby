class Station

	attr_reader :title
	attr_accessor :trains_list

	def initialize(title)
		@title = title
		@trains_list = []
	end

	def arrive(train)
		@trains_list.push(train)
		puts "welcome паровозу № #{train.number}"
	end

	def departure (train)
		if @trains_list.include?(train)
			@trains_list.delete(train)
			puts "buy-buy паровозу № #{train.number}"
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

	def print_type_count
		puts "грузовых на станции #{title} - #{@trains_list.count {|el| el.type == :cargo} }"
		puts "пассажирских на станции #{title} - #{@trains_list.count {|el| el.type == :pass} }"
	end

end