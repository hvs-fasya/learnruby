require_relative 'station'

class Route

	include Validation

	attr_reader :start_station, :last_station
	attr_accessor :inner_stations_list

	validate :start_station, :presence
	validate :last_station, :presence
	validate :start_station, :type, Station
	validate :last_station, :type, Station

	def initialize (start_station,last_station)
		@start_station = start_station
		@last_station = last_station
		@inner_stations_list = []
		validate!
	end

	# def validate!
	# 	raise ArgumentError, "начальная и конечная станции должны быть реально существующими Станциями" if !@start_station.is_a?(Station) #&& !@start_station.is_a?(Depo)
	# 	raise ArgumentError, "начальная и конечная станции должны быть реально существующими Станциями" if !@last_station.is_a?(Station) #&& !@last_station.is_a?(Depo)
	# 	raise ArgumentError, "начальная и конечная станции должны быть разными" if (@last_station == @start_station) && !@start_station.is_a?(Depo)
	# 	true
	# end

	# def valid?
	# 		self.validate!
	# 	rescue ArgumentError
	# 		false
	# end

	def add_station_to_route(station,previous_station)
		if previous_station != @last_station && self.get_full_stations_list.include?(previous_station)
			num = self.get_full_stations_list.index(previous_station)
			@inner_stations_list.insert(num,station)
		else
			puts "не вышло добавить станцию"
		end
	end

	def rm_station_from_route(station)
		case station
			when @last_station
				@last_station = @inner_stations_list[-1]
				@inner_stations_list.delete_at(-1)
				puts "last station deleted, #{@last_station.title} became the last station"
			when @start_station
				@start_station = @inner_stations_list[0]
				@inner_stations_list.delete_at(0)
				puts "start station deleted, #{@start_station} became the start station"
			else
					if @inner_stations_list.delete(station)
					puts "station deleted"
				else
					puts "no such station in route"
				end
		end
	end

	def print_stations_list
		get_full_stations_list.collect{|el| el.title}.join("->")
	end

	#private

	def get_full_stations_list
		[@start_station, @inner_stations_list, @last_station].flatten
	end

end