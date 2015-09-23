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

    private

    def password_validation(res)
      res[0]['password'] == @password
    end
  end
end
