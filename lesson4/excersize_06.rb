# 366 if ((year%4 == 0 and year%100 != 0) or (year%400 == 0)) else 365
puts "Введите число"
date = gets.to_i
puts "Введите номер месяца"
month = gets
puts "Введите год"
year = gets.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
months[1] = ((year % 4 == 0 && year % 100 != 0) or (year % 400 == 0)) ? 29 : 28

result = 0
months.each_with_index {|mon,num| result += mon break if (num > (month - 2))}

result += months[month-1]

puts result