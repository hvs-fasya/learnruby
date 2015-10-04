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

# ---------------------------------------------------------------------
# Вызов главного меню
# процедура и параметры
# ---------------------------------------------------------------------

main_menu.task_procedure = Proc.new {|tasks|
		puts "-----------------------------------------------------------"
		puts "ДОБРО ПОЖАЛОВАТЬ В РЖД"
		puts "Ознакомьтесь с набором команд для управления ж/д процессами"
		puts "-----------------------------------------------------------"
		tasks.each{|el| puts"#{el.command} - #{el.task_description}"}
		puts "-----------------------------------------------------------"
	}
main_menu.task_params = [all_tasks]
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
