module TwitterCli
  class Validator
    def initialize(command_string)
      @command_string = command_string
      @allowed_commands =['timeline'] 
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
