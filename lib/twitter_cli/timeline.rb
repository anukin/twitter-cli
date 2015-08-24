module TwitterCli
  class Timeline
    def initialize(user)
      @user = user
    end

    def get_tweets
      {:user => "anugrah", :tweet => "hello world indeed"}
    end
  end
end
