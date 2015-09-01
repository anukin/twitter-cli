module TwitterCli
  class Parser
    #parser parses the input using some logic
    def initialize(input, name = 0, password = 0)
      @input = input
      @name = name
      @password = password
    end

    def parse
      case @input
      
      when 'timeline'
        get_timeline

      when 'register'
        get_registered

      when 'login'
        login
      end
    end

    private

    def get_timeline
      Timeline.new(@name)
    end

    def get_registered
      UserRegistration.new(@name, @password)
    end

    def login
      UserLogin.new(@name, @password)
    end
  end
end
