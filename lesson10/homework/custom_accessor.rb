# encoding

module CustomAccessor

	# def self.included(base)
	#     base.send :include, InstanceMethods
	# end

	# module InstanceMethods

	def attr_accessor_with_history(*names)
	    names.each do |name|
	        var_name = "@#{name}".to_sym
	        history_name = "@#{name}_history".to_sym

	        define_method(name) { instance_variable_get(var_name) }
	        define_method(history_name) { instance_variable_get(history_name) }

	        define_method("#{name}=") do |value| 
	      		current_value = instance_variable_get(var_name)
	      		current_history_value = instance_variable_get( history_name )
	      		if current_history_value
	      			instance_variable_set(history_name, [])
	      		else
	      			current_history_value.push(current_value)
	      		end
	        	instance_variable_set(var_name, value)
	     	end
	    end
	end

	def strong_attr_acessor (name, type)
		
			var_name = "@#{name}".to_sym

	        define_method(name) { instance_variable_get(var_name) }
	        
	        define_method("#{name}=") do |value| 
	      		current_value = instance_variable_get(var_name)
	      		if value.class.name === type.to_s
	      			instance_variable_set(var_name,value)
	      			puts "value of #{name} has been set to #{value}"
	      		else
	      			raise ArgumentError.new ("Ошибка!!! Значение #{name} должно иметь тип #{type.to_s}")
	      		end
	        end
	    
	end
	# end
end