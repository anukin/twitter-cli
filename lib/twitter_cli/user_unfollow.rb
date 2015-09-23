module TwitterCli
  class UserUnfollow
    def initialize(connection, username, user_to_unfollow)
      @conn = connection
      @username = username
      @user_to_unfollow = user_to_unfollow
    end

    def unfollow
      if validate
        "Pls unfollow someone who exists"
      else
        unless validate_uniqueness
          prepare_delete_statement
          @conn.exec_prepared("delete_user", [@username, @user_to_unfollow])
          "Successfully unfollowed " + @user_to_unfollow
        else
          "You do not follow this user"
        end
      end
    end

    private

    def prepare_delete_statement
      @conn.prepare("delete_user", "delete from follow where username = $1 and following = $2")
    end

    def validate_uniqueness
      res = @conn.exec('select * from follow where username = $1 and following = $2', [@username, @user_to_unfollow])
      res.ntuples == 0
    end
    
    def validate
      res = @conn.exec('select name from users where name = $1', [@user_to_unfollow])
      res.ntuples == 0
    end
  end
end
