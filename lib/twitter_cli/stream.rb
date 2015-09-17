module TwitterCli
  class Stream
    def initialize(connection, username)
      @conn = connection
      @username = username
    end

    def get_stream
      res = @conn.exec('select tweets.id, tweets.username, tweets.tweet from tweets INNER JOIN follow ON (tweets.username = follow.following) and follow.username = $1', [@username])
      aggregate_tweets(res)
    end

    def connect
      @conn = PG.connect(:hostaddr => ENV['hostaddress'], :dbname => ENV['database'], :port => ENV['port'], :user => ENV['username'], :password => ENV['password'])
      #@conn = PG.connect(:dbname => ENV['database'])
    end

    def disconnect
      @conn.close
    end

    def aggregate_tweets(res)
      tweets = []
      res.each do|row|
          tweets << ( row['id'] + " " + row['username'] + " : " + row['tweet'] )
      end
      tweets
    end
  end
end
