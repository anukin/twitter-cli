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
