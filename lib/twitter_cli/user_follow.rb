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
        if validate_uniqueness
          prepare_insert_statement
          @conn.exec_prepared("insert_follower", [@username, @user_to_follow])
          "Successfully followed " + @user_to_follow
        else
          "You have already followed this user"
        end
      end
    end

    private

    def validate
      res = @conn.exec('select name from users where name = $1', [@user_to_follow])
      res.ntuples == 0
    end

    def prepare_insert_statement
      @conn.prepare("insert_follower", "insert into follow (username, following) values ($1, $2)")
    end

    def validate_uniqueness
      res = @conn.exec('select * from follow where username = $1 and following = $2', [@username, @user_to_follow])
      res.ntuples == 0
    end
  end
end
