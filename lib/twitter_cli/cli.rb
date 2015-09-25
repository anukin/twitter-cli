module TwitterCli
  class Cli
    #It is mainly for handling i/o operations
    def run
      puts help
      while 
        print_output(process(get_input))
      end
    end
    
    def process(command_string)
      validator = Validator.new(command_string)
      if validator.validate
        command_processor = "TwitterCli::#{command_string.capitalize}Processor"
        execute(Object.const_get(command_processor))
      else
        "Not a valid command pls type help for use"
      end
    end
    
    private

    def connect
      begin
        PG.connect(:hostaddr => ENV['hostaddress'], :dbname => ENV['database'], :port => ENV['port'], :user => ENV['username'], :password => ENV['password'])
      rescue PG::Error => e
        puts "Sorry but the network seems to be down pls try again"
        exit
      end
    end

    def execute(klass)
      klass.new(connect).execute
    end
    
    def print_output(output)
      puts output
    end
  end
end
