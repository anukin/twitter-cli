module TwitterCli
  class UserLogin
    attr_reader :username, :password
    
    def initialize(connection, username, password)
      @conn = connection
      @username = username
      @password = password
    end

    def process
      res = @conn.exec("select name, password from users where name = $1", [@username])
      if res.ntuples == 0
        "Access denied! No user by that name."
      else
        if password_validation(res)
          Stream.new(@conn, @username).get_stream
        else
          "Access denied! Check your password."
        end
      end
    end

    def ==(other)
      if !self.instance_of?(other.class)
        false
      else
        self.username == other.username && self.password == other.password
      end
    end

    def hash
      [@username.hash, @password.hash].hash
    end

    def eql?(other)
      self == other
    end

    private

    def password_validation(res)
      res[0]['password'] == @password
    end

    def connect
      @conn = PG.connect(:hostaddr => ENV['hostaddress'], :dbname => ENV['database'], :port => ENV['port'], :user => ENV['username'], :password => ENV['password'])
      #@conn = PG.connect('192.168.0.115', 5432, nil, nil, 'twitchblade', 'postgres', 'megamind')
    end

    def disconnect
      @conn.close
    end
  end
end
