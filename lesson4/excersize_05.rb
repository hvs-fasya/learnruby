puts "Введите целое положительное число"
x = gets.to_i

cur_el = 1
factorial = 1

while cur_el <= x
	factorial *= cur_el
	cur_el += 1
end

puts factorial