require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'pass_wagon'
require_relative 'cargo_wagon'
require_relative 'station'
require_relative 'route'
require_relative 'task'

all_tasks = [
	new_station = Task.new("new_station","создать станцию"),
	new_route = Task.new("new_route","создать маршрут"),
	new_train = Task.new("new_train","создать поезд"),
	hook_wagon = Task.new("hook_wagon","добавить вагон к поезду"),
	unhook_wagon = Task.new("unhook_wagon","отцепить вагон от поезда"),
	put_train_at_station = Task.new("put_train_at_station","поместить поезд на станцию"),
	load = Task.new("load","загрузить грузовой вагон"),
	unload = Task.new("unload","разгрузить грузовой вагон"),
	reserve_seat = Task.new("reserve_seat","занять место в пассажирском вагоне"),
	set_seat_free = Task.new("set_seat_free","освободить место в пассажирском вагоне"),
	station_list = Task.new("station_list","просмотреть список станций"),
	trains_list = Task.new("trains_list","просмотреть список поездов на станции"),
	main_menu = Task.new("main_menu","показать главное меню"),
	exit = Task.new("exit","выход")
]

all_stations_list = []
all_routes_list = []
all_trains_list = []
unhooked_cargo_wagons_list = []
unhooked_pass_wagons_list = []


		puts "-----------------------------------------------------------"
		puts "ДОБРО ПОЖАЛОВАТЬ В РЖД"
# ---------------------------------------------------------------------
# Вызов главного меню
# процедура и параметры
# ---------------------------------------------------------------------

main_menu.task_procedure = Proc.new {|tasks|
		puts "-----------------------------------------------------------"
		puts "Ознакомьтесь с набором команд для управления ж/д процессами"
		puts "-----------------------------------------------------------"
		tasks.each{|el| puts"#{el.command} - #{el.task_description}"}
		puts "-----------------------------------------------------------"
	}
main_menu.task_params = [all_tasks]
# ---------------------------------------------------------------------

def with_retry(max_attempts = 3)
    attempt = 0
    begin
      yield
    rescue StandardError => e
      if attempt < max_attempts
        puts  e.message
        attempt += 1
        retry
      else
      	puts  e.message
		puts "даже с #{max_attempts+1} попыток не получилось, едем дальше"
      end
    end
end

# ---------------------------------------------------------------------
# Создание новой станции
# процедура и параметры
# ---------------------------------------------------------------------

new_station.task_procedure = Proc.new {
	with_retry (2) do
		puts "Задайте название станции"
		title_new = gets.strip
		all_stations_list.push(Station.new(title_new))
		puts "создана станция #{all_stations_list[-1].title}"
	end
	}
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# Создание нового маршрута
# процедура и параметры
# ---------------------------------------------------------------------
new_route.task_procedure = Proc.new{
	with_retry (2) do
		if all_stations_list.empty?
			puts "нет ни одной станции - не из чего создавать маршрут"
		else
			puts "Задайте начальную станцию из списка"
			station_list.task_procedure.call
			start_title = gets.strip
			start = all_stations_list.select{|el| el.title == start_title}[0]
			puts "Задайте конечную станцию из списка"
			station_list.task_procedure.call
			last_title = gets.strip
			last = all_stations_list.select{|el| el.title == last_title}[0]
				all_routes_list.push(Route.new(start,last))
				puts "создан новый маршрут #{all_routes_list[-1].start_station.title}->#{all_routes_list[-1].last_station.title}"
		end
	end
	}
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# Создание нового поезда
# процедура и параметры
# ---------------------------------------------------------------------
new_train.task_procedure = Proc.new{
	with_retry (2) do
			puts "Задайте номер нового поезда"
			number_new = gets.strip
			puts "Выберите тип нового поезда: с - грузовой, p - пассажирский"
			type_code = gets.strip
			type_new = (type_code == "c") ? :cargo : :pass
			all_trains_list.push(Train.new(number_new,type_new))
			puts "тип нового поезда #{all_trains_list[-1].type}"
	end
	}
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# Прицепить вагон
# процедура и параметры
# ---------------------------------------------------------------------
hook_wagon.task_procedure = Proc.new{
	with_retry (2) do
		if all_trains_list.empty?
			puts "Нет ни одного поезда - не к чему цеплять"
		else
			puts "Выберите номер поезд из списка"
			all_trains_list.each{|el| puts "#{el.number} (тип #{el.type})"}
			train_number = gets.strip
			train_for_hooking = all_trains_list.select{|el| el.number == train_number}[0]
				if train_for_hooking.type == :cargo
					if unhooked_cargo_wagons_list.empty?
						puts "Задайте вместимость нового вагона (число)"
						capacity = gets.strip.to_i
						train_for_hooking.add_wagon(CargoWagon.new(capacity))
						puts "К поезду № #{train_for_hooking.number} прицеплен новый грузовой вагон - в вагоне свободно #{train_for_hooking.wagons_list[-1].volume_left} ft"
					else
						train_for_hooking.add_wagon(unhooked_cargo_wagons_list[-1])
						puts "К поезду № #{train_for_hooking.number} прицеплен грузовой вагон из резерва - в вагоне свободно #{train_for_hooking.wagons_list[-1].volume_left} ft"
					end
				else
					if unhooked_pass_wagons_list.empty?
						puts "Задайте кол-во мест (целое число)"
						seats = gets.strip.to_i
						train_for_hooking.add_wagon(PassWagon.new(seats))
						puts "К поезду № #{train_for_hooking.number} прицеплен новый пассажирский вагон - в вагоне свободно #{train_for_hooking.wagons_list[-1].seats_left} мест(а)"
					else
						train_for_hooking.add_wagon(unhooked_pass_wagons_list[-1])
						puts "К поезду № #{train_for_hooking.number} прицеплен пассажирский вагон из резерва - в вагоне свободно #{train_for_hooking.wagons_list[-1].seats_left} мест(а)"
					end
				end
		end
	end
	}
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# Отцепить вагон
# процедура и параметры
# ---------------------------------------------------------------------
unhook_wagon.task_procedure = Proc.new{
	if all_trains_list.empty?
		train_for_unhooking = nil
		puts "Нет ни одного поезда - не с чем работать"
	else
		puts "Выберите номер поезд из списка"
		all_trains_list.each{|el| puts "#{el.number} (тип #{el.type})"}
		train_number = gets.strip
		train_for_unhooking = all_trains_list.select{|el| el.number == train_number}[0]
		type = train_for_unhooking.type
	end
	if train_for_unhooking
		if train_for_unhooking.wagons_list.empty?
			puts "в поезде нет вагонов - нечего отцепить"
		else
			puts "Выберите из списка номер вагона, чтобы отцепить"
			train_for_unhooking.wagons_list.each_index{|i| puts i}
			num = gets.strip.to_i
			wagon = train_for_unhooking.wagons_list[num]
			train_for_unhooking.unhook_wagon(wagon)
			type == :cargo ? unhooked_cargo_wagons_list.push(wagon) : unhooked_pass_wagons_list.push(wagon)
		end
	end
	}
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# Загрузить грузовой вагон
# процедура и параметры
# ---------------------------------------------------------------------
load.task_procedure = Proc.new{
	list = all_trains_list.select{|el| el.type == :cargo && !el.wagons_list.empty?}
	if list.empty?
		puts "нет грузовых поездов с прицепленными вагонами - не с чем работать"
	else
		puts "Выберите из списка номер поезда под загрузку"
		list.each{|el| puts "#{el.number} - #{el.wagons_quantity} вагонов(а)"}
		train_number = gets.strip
		train_for_loading = list.select{|el| el.number == train_number}[0]
		puts "Выберите номер вагона из списка"
		train_for_loading.wagons_list.each_index{|i| puts i}
		num = gets.strip.to_i
		wagon = train_for_loading.wagons_list[num]
		puts "Задайте объем загрузки"
		cargo = gets.strip.to_i
		if cargo <= wagon.volume_left
			wagon.load(cargo)
			puts "загружено #{cargo}, свободно - #{wagon.volume_left} ft"
		else
			puts "не вышло погрузить - не влезло"
		end
	end
	}
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# Разгрузить грузовой вагон
# процедура и параметры
# ---------------------------------------------------------------------
unload.task_procedure = Proc.new{
	list = all_trains_list.select{|el| el.type == :cargo && !el.wagons_list.empty?}
	if list.empty?
		puts "нет грузовых поездов с прицепленными вагонами - не с чем работать"
	else
		puts "Выберите из списка номер поезда под загрузку"
		list.each{|el| puts "#{el.number} - #{el.wagons_quantity} вагонов(а)"}
		train_number = gets.strip
		train_for_loading = list.select{|el| el.number == train_number}[0]
		puts "Выберите номер вагона из списка"
		train_for_loading.wagons_list.each_index{|i| puts i}
		num = gets.strip.to_i
		wagon = train_for_loading.wagons_list[num]
		if wagon.volume_occupied > 0
			puts "Задайте объем разгрузки"
			cargo = gets.strip.to_i
			if cargo <= wagon.volume_occupied
				wagon.unload(cargo)
				puts "выгружено #{cargo}, осталось груза - #{wagon.volume_occupied}, свободно - #{wagon.volume_left} ft"
			else
				cargo = wagon.volume_occupied
				wagon.unload(cargo)
				puts "выгружено только #{cargo} - сколько было("
			end
		else
			puts "вагон пустой - нечего выгружать"
		end
	end
	}
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# Занять место в пассажирском вагоне
# процедура и параметры
# ---------------------------------------------------------------------
reserve_seat.task_procedure = Proc.new{
	list = all_trains_list.select{|el| el.type == :pass && !el.wagons_list.empty?}
	if list.empty?
		puts "нет пассажирских поездов с прицепленными вагонами - не с чем работать"
	else
		puts "Выберите из списка номер поезда под посадку"
		list.each{|el| puts "#{el.number} - #{el.wagons_quantity} вагонов(а)"}
		train_number = gets.strip
		train_for_reserve = list.select{|el| el.number == train_number}[0]
		puts "Выберите номер вагона из списка"
		train_for_reserve.wagons_list.each_index{|i| puts i}
		num = gets.strip.to_i
		wagon = train_for_reserve.wagons_list[num]
		if wagon.seats_left > 0
			wagon.reserve_seat
			puts "место занято, свободных - #{wagon.seats_left} мест(а)"
		else
			puts "не вышло - нет свободных мест"
		end
	end
	}
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# Разгрузить грузовой вагон
# процедура и параметры
# ---------------------------------------------------------------------
set_seat_free.task_procedure = Proc.new{
	list = all_trains_list.select{|el| el.type == :pass && !el.wagons_list.empty?}
	if list.empty?
		puts "нет пассажирских поездов с прицепленными вагонами - не с чем работать"
	else
		puts "Выберите из списка номер поезда"
		list.each{|el| puts "#{el.number} - #{el.wagons_quantity} вагонов(а)"}
		train_number = gets.strip
		train_for_set_free = list.select{|el| el.number == train_number}[0]
		puts "Выберите номер вагона из списка"
		train_for_set_free.wagons_list.each_index{|i| puts i}
		num = gets.strip.to_i
		wagon = train_for_set_free.wagons_list[num]
		if wagon.seats_occupied > 0
			wagon.seat_set_free
			puts "место освобождено, свободно - #{wagon.seats_left} мест(а)"
		else
			puts "вагон пустой - нечего освобождать"
		end
	end
	}
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# Поместить поезд на станцию
# процедура и параметры
# ---------------------------------------------------------------------
put_train_at_station.task_procedure = Proc.new{
	if all_trains_list.empty?
		puts "Нет ни одного поезда - не с чем работать"
	elsif all_stations_list.empty?
		puts "Нет ни одной станции - не с чем работать"
	else
		puts "Выберите номер поезд из списка"
		all_trains_list.each{|el| puts "#{el.number}"}
		train_number = gets.strip
		train_for_positioning = all_trains_list.select{|el| el.number == train_number}[0]
		cur_station = train_for_positioning.current_station
		puts "Выберите из списка станцию прибытия"
		station_list.task_procedure.call
		station_title = gets.strip
		station_new = all_stations_list.select{|el| el.title == station_title}[0]
		cur_station.departure(train_for_positioning)
		station_new.arrive(train_for_positioning)
	end
	}
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# Просмотреть список поездов на станции
# процедура и параметры
# ---------------------------------------------------------------------
trains_list.task_procedure = Proc.new{
	puts "Выберите станцию из списка"
	station_list.task_procedure.call
	station_title = gets.strip
	cur_station = all_stations_list.select{|el| el.title == station_title}[0]
	cur_station.trains_list.each{|el| puts "#{el.number} - тип #{el.type}"}
	}
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# Просмотреть список станций
# процедура и параметры
# ---------------------------------------------------------------------
station_list.task_procedure = Proc.new{
	all_stations_list.each {|el| puts el.title}
	}
# ---------------------------------------------------------------------

action = "main_menu"

current_task = all_tasks.select{|task| task.command === action}[0]
current_task.task_procedure.call(*current_task.task_params)

action = gets.strip

while action != "exit" do
	if current_task = all_tasks.select{|task| task.command === action}[0]
		current_task.task_procedure.call(*current_task.task_params)
	else
		puts "нет такой команды"
	end
	action = gets.strip
end