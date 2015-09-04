module TwitterCli
  class Retweet
    def initialize(username, tweeted_by, tweet_id)
      @username = username
      @tweeted_by = tweeted_by
      @tweet_id = tweet_id
    end

    def execute
      connect
      result = post_retweet(retrieve_tweet(@tweet_id), @tweeted_by)
      disconnect
      result
    end

    private

    def post_retweet(retrieve_tweet, tweeted_by)
      tweet = tweeted_by + " : " + retrieve_tweet[0]['tweet']
      tweet_id = retrieve_tweet[0]['id']
      validate_uniqueness(retweet_result(tweet_id), tweet_id, tweet)
    end

    def validate_uniqueness(res, tweet_id, tweet)
      if res.ntuples == 1
        "You have already retweeted this tweet"
      else
        check_retweet(tweet_id, tweet)
      end
    end

    def check_retweet(tweet_id, tweet)
      result = @conn.exec('select * from retweets where retweet_tweet_id = $1', [tweet_id])
      if result.ntuples == 0
        prepare_insert_statement
        tweet_res = @conn.exec_prepared('insert_tweet',[@username, tweet ])
        prepare_insert_retweet
        @conn.exec_prepared('insert_retweet', [tweet_id, @username, tweet_res[0]['id']])
        "Successfully retweeted tweet by " + retrieve_tweet(tweet_id)[0]['username'] + "!"
      else
        result_original_tweet = retrieve_tweet(result[0]['original_tweet_id'])
        id = result_original_tweet[0]['id']
        tweeted_by = result_original_tweet[0]['username']
        post_retweet(retrieve_tweet(id), tweeted_by)
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
