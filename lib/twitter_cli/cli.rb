module TwitterCli
  class Cli
    #It is mainly for handling i/o operations
    def run
      puts help
      while        
        @output = process(get_input)
        print_output
      end
    end
    
    def process(command_string)
      @command_string = command_string
      case command_string
      
      when 'timeline'
        @name = get_name_timeline
        execute_timeline
      
      when 'register', 'login'
        @name = get_name
        @password = get_password
        execute
      
      when 'help'
        return help 
      
      when 'exit'
        exit 
      end
    end
    
    private

    def execute
      parse
      @parsed_input.process
      user_interface = UserInterface.new(@username)
      user_interface.run
    end

    def execute_timeline
      parse
      @parsed_input.process
    end
    
    def parse
      @parser = create_parser(@command_string, @name, @password)
      @parsed_input = @parser.parse
    end
    
    def help
      " ___                                                                       
-   ---___-             ,       ,,          _-_ _,,   ,,        |\         
   (' ||    ;       '  ||       ||             -/  )  ||   _     \\        
  ((  ||    \\/\/\ \\ =||=  _-_ ||/\\         ~||_<   ||  < \,  / \\  _-_  
 ((   ||    || | | ||  ||  ||   || ||          || \\  ||  /-|| || || || \\ 
  (( //     || | | ||  ||  ||   || ||          ,/--|| || (( || || || ||/   
    -____-  \\/\\/ \\  \\, \\,/ \\ |/         _--_-'  \\  \/\\  \\/  \\,/  
                                  _/         (                             " + 
                                 "\nAvailable Commands are" + 
                                 "\ntimeline : for accessing timeline" + 
                                 "\nregister : to register for twitchblade"+
                                 "\nlogin : login to twitchblade"+
                                 "\nhelp : for help" + 
                                 "\nexit : for exit\n"
    end
    
    def print_output
      puts @output
    end
    
    def create_parser(input, name, password)
      Parser.new(input, name, password)
    end
    
    def get_input
      gets.chomp
    end

    def get_name_timeline
      puts "Pls enter the name of user whose timeline you wish to access?\n"
      gets.chomp
    end

    def get_name
      puts "Pls enter the name.\n"
      gets.chomp
    end
    
    def get_password
      puts "Pls enter the password.\n"
      gets.chomp
    end
  end
end
