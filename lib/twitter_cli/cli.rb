require 'io/console'

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
      connect
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
        #graceful exit using break
        exit 
        disconnect
      end
    end
    
    private

    def connect
      @conn = PG.connect(:hostaddr => ENV['hostaddress'], :dbname => ENV['database'], :port => ENV['port'], :user => ENV['username'], :password => ENV['password'])
    end

    def disconnect
      @conn.close
    end

    def execute
      #all puts must be made to functions
      parse
      output = @parsed_input.process
      unless output.class == String && output != "No tweets yet" 
        user_interface = UserInterface.new(@name)
        puts user_interface.help
        puts "Dear " + @name + " your tweets are \n"
        puts output
        user_interface.run
      else
        output
      end
    end

    def execute_timeline
      parse
      @parsed_input.process
    end
    
    def parse
      @parser = create_parser(@conn, @command_string, @name, @password)
      @parsed_input = @parser.parse
    end
    
    def help
      '
 ______       _ __      __     ___  __        __   
/_  __/    __(_) /_____/ /    / _ )/ /__ ____/ /__ 
 / / | |/|/ / / __/ __/ _ \  / _  / / _ `/ _  / -_)
/_/  |__,__/_/\__/\__/_//_/ /____/_/\_,_/\_,_/\__/ 
                                                    ' + 
                                 "\nAvailable Commands are" + 
                                 "\ntimeline : for accessing timeline" +
                                 "\nregister : to register for twitchblade" +
                                 "\nlogin : login to twitchblade" +
                                 "\nhelp : for help" + 
                                 "\nexit : for exit\n"
    end
    
    def print_output
      puts @output
    end
    
    def create_parser(connection, input, name, password)
      Parser.new(connection, input, name, password)
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
      STDIN.noecho(&:gets).chomp
    end
  end
end
