puts "Введите целое число"
x = gets.to_i
interval = (x > 1) ? (1..x) : (x..1)
delimeter = interval.count

#для for
sum_for = 0
for value in interval do
  sum_for += value
end

#для while
el = 1
sum_while = 0
x > 1 ? step = 1 : step = -1
while interval.include?(el) do
  sum_while += el
  el += step
end

#для until
el = 1
sum_until = 0

until !interval.include?(el) do
  sum_until += el
  el += step
end

#для each
sum_each = 0
interval.each{|el| sum_each += el}

puts "Сумма элементов по for: #{sum_for}; ср/арифм: #{sum_for.to_f / delimeter}"
puts "Сумма элементов по while: #{sum_while}; ср/арифм: #{sum_while.to_f / delimeter}"
puts "Сумма элементов по until: #{sum_until}; ср/арифм: #{sum_until.to_f / delimeter}"
puts "Сумма элементов по each: #{sum_each}; ср/арифм: #{sum_each.to_f / delimeter}"
