require_relative 'station'

require 'singleton'

class Depo < Station

	include Singleton

	def initialize(title = "depo")
		super
	end

end