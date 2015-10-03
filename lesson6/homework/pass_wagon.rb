class PassWagon

#Максимальное кол-во мест
#Метод “занять место”  (уменьшает кол-во свободных мест на 1). Нельзя посадить пассажира в вагон, если нет свободных мест
#Метод “освободить место” (увеличивает кол-во свободных мест на  1)
#Может возвращать кол-во оставшихся свободных мест
#Может возвращать кол-во занятых мест.
	attr_reader :seats_max, :seats_occupied, :type
	attr_accessor :hooked

	def initialize(seats_max)
		@seats_max = seats_max
		@seats_occupied = 0
		@type = :pass
		@hooked = false
	end
#возвращает кол-во свободных мест
	def seats_left
		@seats_max - @seats_occupied
	end
#занять место
	def reserve_seat
		@seats_occupied = @seats_occupied < @seats_max ? @seats_occupied + 1 : @seats_occupied
	end
#освободить место
	def seat_set_free
		@seats_occupied = @seats_occupied > 0 ? @seats_occupied - 1 : @seats_occupied
	end
# установка флага "прицеплен"
	def set_hooked
		@hooked = true
	end
# установка флага "отцеплен"
	def set_unhooked
		@hooked = false
	end

	private

	attr_writer :seats_occupied

end

# pWagon = PassWagon.new(2)

# puts "свободно - #{pWagon.seats_left}"
# puts "занято - #{pWagon.seats_occupied}"
# pWagon.reserve_seat
# puts "свободно - #{pWagon.seats_left}"
# puts "занято - #{pWagon.seats_occupied}"
# pWagon.reserve_seat
# puts "занято - #{pWagon.seats_occupied}"
# pWagon.reserve_seat
# puts "занято - #{pWagon.seats_occupied}"
# puts "свободно - #{pWagon.seats_left}"
# pWagon.seat_set_free
# puts "занято - #{pWagon.seats_occupied}"
# puts "свободно - #{pWagon.seats_left}"
# pWagon.seat_set_free
# puts "занято - #{pWagon.seats_occupied}"
# puts "свободно - #{pWagon.seats_left}"
# pWagon.seat_set_free
# puts "занято - #{pWagon.seats_occupied}"
# puts "свободно - #{pWagon.seats_left}"