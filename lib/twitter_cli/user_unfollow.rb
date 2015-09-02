module TwitterCli
  class UserUnfollow
    def initialize(username, user_to_unfollow)
      @username = username
      @user_to_unfollow = user_to_unfollow
    end

    def unfollow
      connect
      if validate
        result = "Pls unfollow someone who exists"
      else
        result = validate_uniqueness
      end
      disconnect
      result
    end

    private

    def prepare_delete_statement
      @conn.prepare("delete_user", "delete from follow where username = $1 and following = $2")
    end

    def validate_uniqueness
      res = @conn.exec('select * from follow where username = $1 and following = $2', [@username, @user_to_unfollow])
      unless res.ntuples == 0
        prepare_delete_statement
        @conn.exec_prepared("delete_user", [@username, @user_to_unfollow])
        "Successfully unfollowed " + @user_to_unfollow
      else
        "You do not follow this user"
      end
    end
    
    def validate
      res = @conn.exec('select name from users where name = $1', [@user_to_unfollow])
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
