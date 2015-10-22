module Validation


		def validate (name, validation_type, param = nil)
			var_name = "@#{name}".to_sym
			rule_name = "@#{name}_#{validation_type}".to_sym
			var_type = "#{validation_type}".to_sym

			rules = {
			:presence => ["!#{var_name}.nil?", "!#{var_name}.empty?"],
			:format => ["!(#{var_name} =~ #{param}).nil?"], 
			:type => ["#{var_name}.is_a?(#{param})"]
			}
			instance_variable_set( "@validation_rules".to_sym, {} ) unless instance_variable_get (:@validation_rules)
			@validation_rules[rule_name] = rules[var_type]
			validation_rules = instance_variable_get(:@validation_rules)
			puts "#{rule_name} has been added"


			define_method ("validate!") do
				validation_rules.each_pair do |rule_name, rule| 
					rule.each do |el|
						puts "evaluating #{rule_name} check..."
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
				true
			end


			define_method ("valid?") do
				begin
					self.validate!
				rescue ArgumentError => e
					puts e.message
					return false
				end
			end

		end

end