module TwitterCli
  class UserRegistration
    def initialize(username, password)
      @username = username
      @password = password
    end

    def register
      connect
      prepare_insert_statement
      res = @conn.exec_prepared("insert_user", [@username, @password])
      disconnect
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
  end
end
