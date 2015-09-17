require 'pg'
module TwitterCli
  class Timeline
    #used for creating timeline of an user
    attr_reader :user
    def initialize(connection, user)
      @conn = connection
      @user = user
    end

    def process
      user_result = @conn.exec('select name from users where name = $1', [@user])
      if validate(user_result)
        "No such user exists"
      else
        res = @conn.exec('select id, username, tweet from tweets where username = $1', [@user])
        if validate(res)
          "No tweets yet"
        else
          aggregate_tweets(res)
        end
      end
    end

    def validate(result)
      result.ntuples == 0 
    end
    
    def ==(other)
      if !self.instance_of?(other.class)
        false
      else
        self.user == other.user
      end
    end

    def hash
      [@user].hash
    end

    def eql?(other)
      self == other
    end
    
    private
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
