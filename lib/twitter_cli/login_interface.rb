module TwitterCli
  class LoginInterface
    #it implements interface to enable accessing the service of twitter cli
    def initialize(username, password)
      @username = username
      @password = password
    end

    def login
      "successfully logged in"
    end
  end
end