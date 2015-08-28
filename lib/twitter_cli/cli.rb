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
      case command_string
      
      when 'timeline'
        name = get_name
      
      when 'register'
        name = get_name
        password = get_password
      
      when 'help'
        return help 
      
      when 'exit'
        exit 
      end
      @parser = create_parser(command_string, name)
      parsed_input = @parser.parse
      execute(parsed_input)
    end
    
    private

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
                                 "\nhelp : for help" + 
                                 "\nexit : for exit\n"
    end
    
    def print_output
      puts @output
    end
    
    def create_parser(input, name)
      Parser.new(input, name)
    end

    def execute(processed_input)
      processed_input.get_tweets
    end
    
    def get_input
      gets.chomp
    end

    def get_name
      puts "Pls enter the name of user whose timeline you wish to access?\n"
      gets.chomp
    end
  end
end
