puts "Введите целое число"
x = gets.to_i
interval = (x > 1) ? (1..x) : (x..1)
delimeter = interval.count / 2

#для each
sum_each = 0
interval.each{|el| el.even? ? sum_each += el : sum_each = sum_each}

puts "Сумма четных элементов по each: #{sum_each}; ср/арифм: #{sum_each.to_f / delimeter}"