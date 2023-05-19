require_relative 'executor'

module Commands
  class Session < Commands::Executor
    def initialize
      @commands = {}
    end

    def register_command(command_name, command)
      @commands[command_name] = command
    end

    def execute_command(command_name, inputs)
      command = @commands[command_name]
      raise 'Invalid Command' if command.nil?

      command.execute(inputs)
    end
  end
end
