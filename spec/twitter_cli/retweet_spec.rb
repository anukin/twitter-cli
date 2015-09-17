require 'spec_helper'

module TwitterCli
  describe "retweet" do
    let(:conn) { PG.connect(:dbname => ENV['database']) }
    let(:tweets) { [] }
    def helper_get_tweets(res)
      res.each do|row|
        tweets << row['tweet']
      end
      tweets
    end
    
    it "the retweeted message must be a part of user's timeline" do
      username = 'red'
      tweeted_by = 'anugrah'
      tweet_id = 97
      tweet = "anugrah : foo bar baz"
      conn.exec('begin')
      res_red = conn.exec('select tweet from tweets where username = $1', ['red'])
      retweet = Retweet.new(conn, username, tweet_id)
      retweet.execute
      expect(helper_get_tweets(res_red)).to include(tweet)
    end

    it "should allow retweet only once for a specific user and retweet" do
      username = 'red'
      tweeted_by = 'anugrah'
      tweet_id = 97
      retweet = Retweet.new(conn, username, tweet_id)
      expect(retweet.execute).to eq("You have already retweeted this tweet")
      conn.exec('rollback')
    end

    it "should allow retweet of original tweet by the user" do
      username = 'lol'
      tweeted_by = 'red'
      tweet_id = 107
      conn.exec('begin')
      res_lol = conn.exec('select tweet from tweets where username = $1', ['lol'])
      retweet = Retweet.new(conn, username, tweet_id)
      tweet = "anugrah : foo bar baz"
      retweet.execute
      expect(helper_get_tweets(res_lol)).to include(tweet)
      conn.exec('rollback')
    end
  end
end
