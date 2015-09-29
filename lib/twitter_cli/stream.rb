module TwitterCli
  class Stream
    def initialize(connection, username)
      @conn = connection
      @username = username
    end

    def get_stream
      #it should be a build of objjects rathere than aggragate of tweets 
      res = @conn.exec('select tweets.id, tweets.username, tweets.tweet from tweets INNER JOIN follow ON (tweets.username = follow.following) and follow.username = $1', [@username])
      aggregate_tweets(res)
    end
    
    private

    def aggregate_tweets(res)
      tweets = []
      res.each do|row|
          tweets << ( row['id'] + " " + row['username'] + " : " + row['tweet'] )
      end
      tweets
    end
  end
end
