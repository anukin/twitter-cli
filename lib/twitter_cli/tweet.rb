module TwitterCli
  class Tweet
    def initialize(username, tweet)
      @username = username
      @tweet = tweet
    end

    def send_tweet
      connect
      prepare_insert_statement
      @conn.exec_prepared("insert_tweet", [@username, @tweet])
      disconnect
    end

    private
    
    def connect
      @conn = PG.connect( :dbname => ENV['database'])
      #@conn = PG.connect('192.168.0.115', 5432, nil, nil, 'twitchblade', 'postgres', 'megamind')
    end

    def disconnect
      @conn.close
    end

    def prepare_insert_statement
      @conn.prepare("insert_tweet", "insert into tweets (username, tweet) values ($1, $2)")
    end
  end
end