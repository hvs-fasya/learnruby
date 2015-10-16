require_relative 'route'
require_relative 'depo'
require 'singleton'

class Nowhere < Route

	include Singleton

	def initialize(start_station = Depo.instance, last_station = Depo.instance)
		super
	end

end