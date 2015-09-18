module TwitterCli
  class Retweet
    def initialize(connection, username, tweet_id)
      @conn = connection
      @username = username
      @tweet_id = tweet_id
    end

    def execute
      post_retweet(@tweet_id)
    end

    private

    def post_retweet(tweet_id)
      validate_uniqueness(retweet_result(tweet_id), tweet_id)
    end

    def validate_uniqueness(res, tweet_id)
      if res.ntuples == 1
        "You have already retweeted this tweet"
      else
        if check_retweet(tweet_id)
          tweet_result = retrieve_tweet(tweet_id)
          tweeted_by = tweet_result[0]['username']
          tweet = tweeted_by + " : " + tweet_result[0]['tweet']
          Tweet.new(@conn, @username, tweet).tweet
          prepare_insert_retweet
          @conn.exec_prepared('insert_retweet', [tweet_id, @username, tweet_res[0]['id']])
          "Successfully retweeted tweet by " + retrieve_tweet(tweet_id)[0]['username'] + "!"
        else
          result_original_tweet = retrieve_tweet(@result[0]['original_tweet_id'])
          id = result_original_tweet[0]['id']
          post_retweet(id)
        end
      end
    end

    private
    
    def check_retweet(tweet_id)
      @result = @conn.exec('select * from retweets where retweet_tweet_id = $1', [tweet_id])
      @result.ntuples == 0
    end
    
    def retweet_result(tweet_id)
      @conn.exec('select * from retweets where retweeted_by = $1 and original_tweet_id = $2', [@username, tweet_id])
    end
    
    def prepare_insert_retweet
      @conn.prepare("insert_retweet", "insert into retweets(original_tweet_id, retweeted_by, retweet_tweet_id) values ( $1, $2, $3 )")
    end

    def retrieve_tweet(tweet_id)
      @conn.exec('select * from tweets where id = $1', [tweet_id])
    end

    def connect
      #@conn = PG.connect( :dbname => ENV['database'])
      @conn = PG.connect('192.168.1.19', 5432, nil, nil, 'twitchblade', 'postgres', 'megamind')
    end

    def disconnect
      @conn.close
    end
  end
end
