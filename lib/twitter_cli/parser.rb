module TwitterCli
  class Parser
    def initialize(input)
      @input = input
    end

    def parse
      case @input
      when 'timeline'
        Timeline.new('red')
      end
    end
  end
end
