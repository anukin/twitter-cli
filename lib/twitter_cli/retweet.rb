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
      @tweet = @tweeted_by + " : " + retrieve_tweet
      validate_uniqueness(retweet_result)
    end

    def validate_uniqueness(res)
      if res.ntuples == 1
        "You have already retweeted this tweet"
      else
        prepare_insert_statement
        tweet_res = @conn.exec_prepared('insert_tweet',[@username, @tweet ])
        prepare_insert_retweet
        @conn.exec_prepared('insert_retweet', [@tweet_id, @username, tweet_res[0]['id']])
        "Successfully retweeted tweet by " + @tweeted_by + "!"
      end
    end

    def retweet_result
      @conn.exec('select * from retweets where retweeted_by = $1 and original_tweet_id = $2', [@username, @tweet_id])
    end
    
    def prepare_insert_statement
      @conn.prepare("insert_tweet", "insert into tweets(username, tweet) values ( $1, $2 ) returning id")
    end

    def prepare_insert_retweet
      @conn.prepare("insert_retweet", "insert into retweets(original_tweet_id, retweeted_by, retweet_tweet_id) values ( $1, $2, $3 )")
    end

    def retrieve_tweet
      @res = @conn.exec('select * from tweets where id = $1', [@tweet_id])
      @res[0]['tweet']
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
