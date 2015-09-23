module TwitterCli
  class Tweet
    attr_reader :username, :tweet
    
    def initialize(conn,username, tweet)
      @conn = conn
      @username = username
      @tweet = tweet
    end

    def send_tweet
      prepare_insert_statement
      @conn.exec_prepared("insert_tweet", [@username, @tweet])
      "Successfully tweeted"
    end

    def ==(other)
      if !self.instance_of?(other.class)
        false
      else
        self.username == other.username && self.tweet == other.tweet
      end
    end

    def hash
      [@username, @tweet].hash
    end

    private
    
    def prepare_insert_statement
      @conn.prepare("insert_tweet", "insert into tweets (username, tweet) values ($1, $2)")
    end
  end
end