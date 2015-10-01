puts "Введите целое число"
x = gets.to_i
puts "Введите число делитель"
y = gets.to_i
interval = (x > 1) ? (1..x) : (x..1)
delimeter = (x > 1) ? x / y : x.abs / y + 1

#для each
sum_each = 0
interval.each{|el| sum_each = (el % y == 0) ? sum_each += el : sum_each}

puts "Сумма элементов делящихся на #{y}: #{sum_each}; ср/арифм: #{sum_each.to_f / delimeter}"