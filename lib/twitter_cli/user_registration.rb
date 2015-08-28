module TwitterCli
  class UserRegistration
    #A class specifically in place for registering an user for twitch blade services
    attr_reader :username , :password
    def initialize(username, password)
      @username = username
      @password = password
    end

    def process
      connect
      prepare_insert_statement
      if validate
        @conn.exec_prepared("insert_user", [@username, @password])
        @timeline = create_timeline
        res = @timeline.process
      else
        res = "Another user exists with same name pls go for some other username!"
      end
      disconnect
      res
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
    
    def connect
      #@conn = PG.connect(:dbname => ENV['database'])
      @conn = PG.connect('192.168.0.115', 5432, nil, nil, 'twitchblade', 'postgres', 'megamind')
    end

    def disconnect
      @conn.close
    end

    def prepare_insert_statement
      @conn.prepare("insert_user", "insert into users (name, password) values ($1, $2)")
    end

    def validate
      temp_res = @conn.exec('select name from users where name = $1', [@username])
      temp_res.ntuples == 0
    end

    def create_timeline
      Timeline.new(@username)
    end
  end
end
