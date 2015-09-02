module TwitterCli
  class UserUnfollow
    def initialize(username, user_to_follow)
      @username = username
      @user_to_follow = user_to_follow
    end

    def unfollow
      connect
      disconnect
      "Successfully unfollowed red"
    end

    private

    def connect
      @conn = PG.connect(:dbname => ENV['database'])
    end

    def disconnect
      @conn.close
    end
  end
end
