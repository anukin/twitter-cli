module TwitterCli
  class Validator
    def initialize(command_string)
      @command_string = command_string
      @allowed_commands =['timeline', 'register', 'login', 'help', 'exit']
    end

    def validate
      if @allowed_commands.include? @command_string
        true
      else
        false
      end
    end
  end
end
