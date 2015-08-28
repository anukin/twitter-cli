module TwitterCli
  class UserRegistration
    def initialize(username, password)
      @username = username
      @password = password
    end

    def register
      connect
      prepare_insert_statement
      if validate
        res = @conn.exec_prepared("insert_user", [@username, @password])
      else
        res = "Another user exists with same name pls go for some other username!"
      end
      disconnect
      res
    end

    private
    def connect
      @conn = PG.connect(:dbname => ENV['database'])
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
  end
end
