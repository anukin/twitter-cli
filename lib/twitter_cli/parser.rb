module TwitterCli
  class Parser
    #parser parses the input using some logic
    def initialize(input, name = 0)
      @input = input
      @name = name
    end

    def parse
      case @input
      when 'timeline'
        get_timeline
      when 'exit'
        exit
      when 'help'
        :help
      end
    end

    private

    def get_timeline
      timeline = Timeline.new(@name)
    end
  end
end
