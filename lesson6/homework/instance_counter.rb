module InstanceCounter

	def self.included(base)
		base.instances ||= 0
	    base.extend ClassMethods
	    base.send :include, InstanceMethods
	end

	module ClassMethods

		@@instances = 0
		
		def instances
			@@instances
		end

		def register_instance
			@@instances += 1
		end
	end

	module InstanceMethods

		def instances
			self.class.instances
		end

		protected

		def register_instance
			self.class.register_instance
		end
	end

end


