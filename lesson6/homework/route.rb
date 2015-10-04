require_relative 'station'

class Route

	attr_reader :start_station, :last_station
	attr_accessor :inner_stations_list

	def initialize (start_station,last_station)
		@start_station = start_station
		@last_station = last_station
		@inner_stations_list = []
	end

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
		readable = get_full_stations_list.collect{|el| el.title}.join("->")
		puts readable
	end

	#private

	def get_full_stations_list
		[@start_station, @inner_stations_list, @last_station].flatten
	end

end