module TwitterCli
  class Stream
    def initialize(username)
      @username = username
    end

    def get_stream
      connect
      res = @conn.exec('select tweets.tweet from tweets INNER JOIN follow ON (tweets.username = follow.following) and follow.username = $1', [@username])
      result = aggregate_tweets(res)
      disconnect
      result
    end

    def connect
      #@conn = PG.connect(:hostaddr => ENV['hostaddress'], :dbname => ENV['database'], :port => ENV['port'], :user => ENV['username'], :password => ENV['password'])
      @conn = PG.connect(:dbname => ENV['database'])
    end

    def disconnect
      @conn.close
    end

    def aggregate_tweets(res)
      tweets = []
      res.each do|row|
          tweets << row['tweet']
      end
      tweets
    end
  end
end
