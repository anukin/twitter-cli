require 'spec_helper'

module TwitterCli
  describe "tweet : " do
    let(:conn) { PG.connect(:dbname => ENV['database']) }
    let(:tweets) { [] }
    def helper_get_tweets(res)
      res.each do|row|
        tweets << row['tweet']
      end
      tweets
    end
    
    context 'tweeting' do
      it "should be possible for the user" do
        conn.exec('begin')
        username = 'anugrah'
        msg = 'foo bar baz'
        tweet = Tweet.new(conn, username, msg)
        tweet.send_tweet
        res_anugrah = conn.exec('select tweet from tweets where username = $1', ['anugrah'])
        expect(helper_get_tweets(res_anugrah)).to include(msg)
        conn.exec('rollback')
      end
    end

    context 'equality' do
      it "should be reflexive in nature" do
        username = 'anugrah'
        message = 'lol'
        tweet_1 = Tweet.new(conn, username, message)
        tweet_2 = Tweet.new(conn, username, message)
        expect(tweet_1).to eq(tweet_2)
      end

      it "should be symmetric in nature" do
        username = 'anugrah'
        message = 'lol'
        tweet_1 = Tweet.new(conn, username, message)
        tweet_2 = Tweet.new(conn, username, message)
        expect(tweet_2).to eq(tweet_1)
      end

      it "should be transitive in nature" do
        username = 'anugrah'
        message = 'lol'
        tweet_1 = Tweet.new(conn, username, message)
        tweet_2 = Tweet.new(conn, username, message)
        tweet_3 = Tweet.new(conn, username, message)
        expect(tweet_1).to eq(tweet_2)
        expect(tweet_2).to eq(tweet_3)
        expect(tweet_1).to eq(tweet_3)
      end

      it "is not equal to nil" do
        username = 'anugrah'
        message = 'lol'
        tweet_1 = Tweet.new(conn, username, message)
        expect(tweet_1).to_not eq(nil)
      end

      it "is not equal for different types" do
        username = 'anugrah'
        message = 'lol'
        tweet_1 = Tweet.new(conn, username, message)
        expect(tweet_1).to_not eq(Object.new)
      end

      it "hashes must be same if objects are same" do
        username = 'anugrah'
        message = 'lol'
        tweet_1 = Tweet.new(conn, username, message)
        tweet_2 = Tweet.new(conn, username, message)
        expect(tweet_1.hash).to eq(tweet_2.hash)
      end
    end
  end
end
