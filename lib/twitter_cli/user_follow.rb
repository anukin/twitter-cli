module TwitterCli
  class UserFollow
    def initialize(connection, username, user_to_follow)
      @conn = connection
      @username = username
      @user_to_follow = user_to_follow
    end

    def follow
      if validate
        "Pls follow someone who exists"
      else
        validate_uniqueness
      end
    end
    private
    
    def connect
      @conn = PG.connect(:hostaddr => ENV['hostaddress'], :dbname => ENV['database'], :port => ENV['port'], :user => ENV['username'], :password => ENV['password'])
    end

    def disconnect
      @conn.close
    end

    def validate
      res = @conn.exec('select name from users where name = $1', [@user_to_follow])
      res.ntuples == 0
    end

    def prepare_insert_statement
      @conn.prepare("insert_user", "insert into follow (username, following) values ($1, $2)")
    end

    def validate_uniqueness
      res = @conn.exec('select * from follow where username = $1 and following = $2', [@username, @user_to_follow])
      if res.ntuples == 0
        prepare_insert_statement
        @conn.exec_prepared("insert_user", [@username, @user_to_follow])
        "Successfully followed " + @user_to_follow
      else
        "You have already followed this user"
      end
    end
  end
end
