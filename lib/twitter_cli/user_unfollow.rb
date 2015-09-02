module TwitterCli
  class UserUnfollow
    def initialize(username, user_to_follow)
      @username = username
      @user_to_follow = user_to_follow
    end

    def unfollow
      connect
      if validate
        result = "Pls unfollow someone who exists"
      else
        result = "Successfully unfollowed red"
      end
      disconnect
      result
    end

    private
    
    def validate
      res = @conn.exec('select name from users where name = $1', [@user_to_follow])
      res.ntuples == 0
    end
    
    def connect
      @conn = PG.connect(:dbname => ENV['database'])
    end

    def disconnect
      @conn.close
    end
  end
end
