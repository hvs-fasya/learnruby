module Validation


	def self.included(base)
		
		base.extend ClassMethods
	    base.send :include, InstanceMethods
	end


	module ClassMethods

		class_variable_set( "@@validation_rules".to_sym, {} )

		def validation_rules
			@@validation_rules
		end

		def validate (name, validation_type, param = nil)
			context = self.to_s.downcase
			var_name = "@#{name}".to_sym
			rule_name = "@@#{context}_#{name}_#{validation_type}".to_sym
			var_type = "#{validation_type}".to_sym

			rules = {
			:presence => ["!#{var_name}.nil?", "!#{var_name}.empty?"],
			:format => ["!(#{var_name} =~ #{param}).nil?"], 
			:type => ["#{var_name}.is_a?(#{param})"]
			}
			class_variable_set( rule_name, rules[var_type] )
			# define_singleton_method("#{context}_#{name}_#{validation_type}".to_sym) {class_variable_get( rule_name )}
			self.validation_rules[rule_name] = rules[var_type]
		end
	end


	module InstanceMethods

		def validate!
			self.class.validation_rules.each_pair do |rule_name, rule| 
				rule.each do |el|
					context = self.class.name.downcase
					if context === rule_name.to_s.split("@@")[1].split("_").first
						puts "evaluation #{rule_name}..."
						rule_type = rule_name.to_s.split('_').last
						var_name = rule_name.to_s.gsub("_#{rule_type}",'')
						validation_result = eval(el)
						if validation_result === false
							raise ArgumentError, "задано пустое значение #{var_name} или не задано вовсе" if rule_type === "presence"
							raise ArgumentError, "неверный формат параметра #{var_name}" if rule_type === "format"
							raise ArgumentError, "неверный тип параметра #{var_name}" if rule_type === "type"
						end
					end
				end
			end
			true
		end

		def valid?
			self.validate!
		rescue ArgumentError => e
			puts e.message
			false
		end

	end

end