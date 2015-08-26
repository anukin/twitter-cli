module TwitterCli
  class Cli
    #It is mainly for handling i/o operations
    def run
      while        
        intermediate_output = parse(get_input)
        execute(intermediate_output)
      end
    end
    
    def process(command_string)
      if command_string == "timeline"
        name = get_name
      end
      @parser = create_parser(command_string, name)
      @parser.parse
    end

    def execute(processed_input)
      processed_input.get_tweets
    end

    private
    
    def create_parser(input, name)
      Parser.new(input, name)
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
