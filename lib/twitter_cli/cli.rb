module TwitterCli
  class Cli
    def infinite_input
      menu
      while
        input = gets.chomp
        parse(input)
      end
    end
    
    def parse(input)
      @input = input
      case @input
      when 'timeline'
        get_timeline
      when 'exit'
        exit
      end
    end

    private 
    
    def get_timeline
      puts "Pls give me the name of user whose timeline you wish to access? \n"
      name = gets.chomp
      timeline = Timeline.new(name)
      puts timeline.get_tweets
    end

    def menu
      puts "Available commands :: timeline, exit etc \n"
    end
  end
end
