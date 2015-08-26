require 'pg'
module TwitterCli
  class Timeline
    attr_reader :user
    def initialize(user)
      @user = user
    end

    def get_tweets
      connect
      tweets = []
      res = @conn.exec('select tweet from tweets where username = $1', [@user])
      disconnect
      if validate(res)
        "No such user exists"
      else
        res.each do|row|
          tweets << row['tweet']
        end
        
        tweets
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
      @conn = PG.connect(:dbname => ENV['database'])
    end

    def disconnect
      @conn.close
    end
  end
end
