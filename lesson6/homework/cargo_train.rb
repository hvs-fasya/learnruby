require_relative 'train'

class CargoTrain < Train

	def initialize(number,type = :cargo)
		super
	end

end

#cargo_122 = CargoTrain.new(122,4,:pass)
#puts cargo_122.print_type