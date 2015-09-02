module TwitterCli
  class UserFollow
    def initialize(username, user_to_follow)
      @username = username
      @user_to_follow = user_to_follow
    end

    def follow
      "Successfully followed " + @user_to_follow
    end
  end
end
