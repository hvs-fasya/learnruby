require_relative 'train'

class PassengerTrain < Train

	def initialize(number,type = :pass)
		super
	end

end

pass_16 = PassengerTrain.new(16,8)