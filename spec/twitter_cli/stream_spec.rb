require 'spec_helper'

module TwitterCli
  describe "stream" do
    let(:conn) { PG.connect(:dbname => ENV['database']) }
    let(:res_anugrah) { conn.exec('select tweets.id, tweets.username, tweets.tweet from tweets INNER JOIN follow ON (tweets.username = follow.following) and follow.username = $1', ['anugrah']) }
    let(:res_red) { conn.exec('select tweets.id, tweets.username, tweets.tweet from tweets INNER JOIN follow ON (tweets.username = follow.following) and follow.username = $1', ['red']) }
    let(:tweets) { [] }
    def helper_get_stream(res)
      res.each do|row|
        tweets << ( row['id'] + " " + row['username'] + " : " + row['tweet'] )
      end
      tweets
    end
    
    it "should return the tweets of all users which a certain user follows" do
      username = 'anugrah'
      stream = Stream.new(username)
      expect(stream.get_stream).to eq(helper_get_stream(res_anugrah))
    end

    it "should return the tweets of all users which a certain user follows" do
      username = 'red'
      stream = Stream.new(username)
      expect(stream.get_stream).to eq(helper_get_stream(res_red))
    end
  end
end
