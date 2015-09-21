module TwitterCli
  class Parser
    #parser parses the input using some logic
    def initialize(connection, input, name = 0, password = 0)
      @conn = connection
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
      Timeline.new(@conn, @name)
    end

    def get_registered
      UserRegistration.new(@conn, @name, @password)
    end

    def login
      UserLogin.new(@conn, @name, @password)
    end
  end
end
