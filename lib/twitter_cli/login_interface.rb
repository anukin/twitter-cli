module TwitterCli
  USER_HASH = {
    "anugrah" => "lol"
  }
  class LoginInterface
    #it implements interface to enable accessing the service of twitter cli
    def initialize(username, password)
      @username = username
      @password = password
    end

    def login
      if password_check
        "successfully logged in"
      else
        "Access denied!"
      end
    end

    private
    
    def password_check
      USER_HASH.keys.include?(@username) && USER_HASH[@username] == @password
    end
  end
end