class Task
	
	attr_reader :command, :task_description
	attr_accessor :task_procedure, :task_params

	def initialize (command,task_description)
		@command = command
		@task_description = task_description
		@task_procedure = default_proc()
		@task_params = []
	end

	def default_proc
		Proc.new {puts "метод неопределен"}
	end

end
