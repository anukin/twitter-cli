require 'pg'
module TwitterCli
  class Timeline
    #used for creating timeline of an user
    attr_reader :user
    def initialize(user)
      @user = user
    end

    def process
      connect
      @tweets = []
      @user_result = @conn.exec('select name from users where name = $1', [@user])
      if validate(@user_result)
        output = "No such user exists"
      else
        @res = @conn.exec('select tweet from tweets where username = $1', [@user])
        if validate(@res)
          output = "No tweets yet"
        else
          aggregate_tweets
          output = @tweets
        end
      end
      disconnect
      output
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
      @conn = PG.connect('192.168.0.115', 5432, nil, nil, 'twitchblade', 'postgres', 'megamind')
      #@conn = PG.connect(:dbname => ENV['database'])
    end

    def disconnect
      @conn.close
    end

    def aggregate_tweets
      @res.each do|row|
          @tweets << row['tweet']
      end
    end
  end
end
