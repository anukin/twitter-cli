module TwitterCli
  class Parser
    def initialize(input)
      @input = input
    end

    def parse
      case @input
      when 'timeline'
        get_timeline
      end
    end

    private

    def get_timeline
      puts "Pls give me the name of user whose timeline you wish to access? \n"
      name = gets.chomp
      timeline = Timeline.new(name)
    end
  end
end
