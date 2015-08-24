module TwitterCli
  class Timeline
    def initialize(user)
      @user = user
    end

    def get_tweets
      ["hello world indeed", "shine on you crazy diamond"]
    end
  end
end
