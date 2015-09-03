module TwitterCli
  class Retweet
    def initialize(username, tweeted_by, tweet_id)
      @username = username
      @tweeted_by = tweeted_by
      @tweet_id = tweet_id
    end

    def execute
      connect
      result = post_retweet(retrieve_tweet)
      disconnect
      result
    end

    private

    def post_retweet(retrieve_tweet)
      "Successfully retweeted tweet by anugrah!"
    end

    def retrieve_tweet
    end

    def connect
      @conn = PG.connect( :dbname => ENV['database'])
      #@conn = PG.connect('192.168.0.115', 5432, nil, nil, 'twitchblade', 'postgres', 'megamind')
    end

    def disconnect
      @conn.close
    end
  end
end
