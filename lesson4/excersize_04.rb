puts "Введите целое положительное число"
x = gets.to_i

cur_el = 1
sum = 0

while cur_el <= x
	sum += (cur_el**cur_el)
	cur_el += 1
end

puts sum