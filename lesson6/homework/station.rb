class Station

	
	attr_reader :title

	def initialize(title)
		@title = title
		@trains_list = []
		validate!
	end

	def validate!
		raise ArgumentError, "не задано название станции" if @title.nil?
		raise ArgumentError, "задано пустое название станции" if @title.empty?
		raise ArgumentError, "какое-то немыслимое название станции" if @title !~ /^[a-zA-Z0-9][a-zA-Z0-9\s-_]+$/
		true
	end

	def valid?
			self.validate!
		rescue ArgumentError
			false
	end

	def arrive(train)
		@trains_list.push(train)
		train.current_station = self
		puts "welcome паровозу № #{train.number} на станции #{@title}"
	end

	def departure (train)
		if @trains_list.include?(train)
			@trains_list.delete(train)
			train.current_station = Depo.instance
			puts "buy-buy паровозу № #{train.number} со станции #{@title}"
		else
			puts "на станции #{@title}нет такого паровоза"
		end
	end

	def trains_list
		@trains_list.clone
	end

	def print_trains_list
		if @trains_list.empty?
			puts "на станции #{title} нет ни одного паровоза"
		else
			puts "на станции #{title} находятся #{get_readable_trains_list}"
		end
	end

	def print_type_count
		puts "грузовых на станции #{title} - #{get_cargo_trains_list.count}: #{get_cargo_trains_list.join(", ")}"
		puts "пассажирских на станции #{title} - #{get_pass_trains_list.count}: #{get_pass_trains_list.join(", ")}"
	end

	def call_method_for_each_train
      	trains_list.each {|el| yield el }
    end  

	def print_all_trains_info 
		call_method_for_each_train { |train| train.print_train_info }
	end

	private

	def get_readable_trains_list
		@trains_list.collect { |train|  "паровоз № #{train.number}" }.join(", ")
	end

	def get_cargo_trains_list
		@trains_list.map {|el| "паровоз № #{el.number}" if el.type == :cargo}.compact
	end

	def get_pass_trains_list
		 @trains_list.map {|el| "паровоз № #{el.number}" if el.type == :pass}.compact
	end

end