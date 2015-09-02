module TwitterCli
  class UserFollow
    def initialize(username, user_to_follow)
      @username = username
      @user_to_follow = user_to_follow
    end

    def follow
      connect
      if validate
        result = "Pls follow someone who exists"
      else
        result = "Successfully followed " + @user_to_follow
      end
      disconnect
      result
    end
    private
    
    def connect
      @conn = PG.connect(:dbname => ENV['database'])
    end

    def disconnect
      @conn.close
    end

    def validate
      res = @conn.exec('select name from users where name = $1', [@user_to_follow])
      res.ntuples == 0
    end
  end
end
