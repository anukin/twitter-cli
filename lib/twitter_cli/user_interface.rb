module TwitterCli
  class UserInterface
    def initialize(username)
      @username = username
    end

    def run
      @output = process(get_input)
      print_output
    end

    def process(command)
      case command
      when 'help'
        ' __      __       .__                                
/  \    /  \ ____ |  |   ____  ____   _____   ____   
\   \/\/   _/ __ \|  | _/ ___\/  _ \ /     \_/ __ \  
 \        /\  ___/|  |_\  \__(  <_> |  Y Y  \  ___/  
  \__/\  /  \___  |____/\___  \____/|__|_|  /\___  > 
       \/       \/          \/            \/     \/  
       ' + @username + ' to TwitchBlade
            help
       tweet : for tweeting
       help  : for displaying help'
      end
    end

    def get_input
      gets.chomp
    end

    def print_input
      puts @output
    end
  end
end
