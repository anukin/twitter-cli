module TwitterCli
  class UserRegistration
    #A class specifically in place for registering an user for twitch blade services
    attr_reader :username , :password
    def initialize(connection, username, password)
      @conn = connection
      @username = username
      @password = password
    end

    def process
      prepare_insert_statement
      if validate
        @conn.exec_prepared("insert_user", [@username, @password])
        @timeline = create_timeline
        @timeline.process
      else
        "Another user exists with same name pls go for some other username!"
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

    def prepare_insert_statement
      @conn.prepare("insert_user", "insert into users (name, password) values ($1, $2)")
    end

    def validate
      temp_res = @conn.exec('select name from users where name = $1', [@username])
      temp_res.ntuples == 0
    end

    def create_timeline
      Timeline.new(@conn, @username)
    end
  end
end
