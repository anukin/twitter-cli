module TwitterCli
  class UserLogin
    def initialize(username, password)
      @username = username
      @password = password
    end

    def login
      connect
      validate
    end

    private
    def validate
      res = @conn.exec("select name, password from users where name = $1", [@username])
      if res.ntuples == 0
        "No!"
      else
        password_validation(res)
      end
    end

    def password_validation(res)
      if res[0]['password'] == @password
        "Successfully logged in!"
      else
        "No!"
      end
    end

    def connect
      @conn = PG.connect(:dbname => ENV['database'])
      #@conn = PG.connect('192.168.0.115', 5432, nil, nil, 'twitchblade', 'postgres', 'megamind')
    end

    def disconnect
      @conn.close
    end
  end
end
