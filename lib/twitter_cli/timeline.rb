require 'pg'
module TwitterCli
  class Timeline
    def initialize(user)
      @user = user
    end

    def get_tweets
      connect
      tweets = []
      res = @conn.exec('select * from tweets where username = $1', [@user])
      disconnect
      res.each do|row|
        tweets << row['tweet']
      end
      tweets
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
