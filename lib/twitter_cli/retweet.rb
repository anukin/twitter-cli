module TwitterCli
  class Retweet
    def initialize(username, tweet_id)
      @username = username
      @tweet_id = tweet_id
    end

    def execute
      connect
      result = post_retweet(@tweet_id)
      disconnect
      result
    end

    private

    def post_retweet(tweet_id)
      validate_uniqueness(retweet_result(tweet_id), tweet_id)
    end

    def validate_uniqueness(res, tweet_id)
      if res.ntuples == 1
        "You have already retweeted this tweet"
      else
        check_retweet(tweet_id)
      end
    end

    def check_retweet(tweet_id)
      result = @conn.exec('select * from retweets where retweet_tweet_id = $1', [tweet_id])
      tweet_result = retrieve_tweet(tweet_id)
      tweeted_by = tweet_result[0]['username']
      tweet = tweeted_by + " : " + tweet_result[0]['tweet']
      if result.ntuples == 0
        prepare_insert_statement
        tweet_res = @conn.exec_prepared('insert_tweet',[@username, tweet ])
        prepare_insert_retweet
        @conn.exec_prepared('insert_retweet', [tweet_id, @username, tweet_res[0]['id']])
        "Successfully retweeted tweet by " + retrieve_tweet(tweet_id)[0]['username'] + "!"
      else
        result_original_tweet = retrieve_tweet(result[0]['original_tweet_id'])
        id = result_original_tweet[0]['id']
        post_retweet(id)
      end
    end
    
    def retweet_result(tweet_id)
      @conn.exec('select * from retweets where retweeted_by = $1 and original_tweet_id = $2', [@username, tweet_id])
    end
    
    def prepare_insert_statement
      @conn.prepare("insert_tweet", "insert into tweets(username, tweet) values ( $1, $2 ) returning id")
    end

    def prepare_insert_retweet
      @conn.prepare("insert_retweet", "insert into retweets(original_tweet_id, retweeted_by, retweet_tweet_id) values ( $1, $2, $3 )")
    end

    def retrieve_tweet(tweet_id)
      @conn.exec('select * from tweets where id = $1', [tweet_id])
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
