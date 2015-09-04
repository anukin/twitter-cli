require 'spec_helper'

module TwitterCli
  describe 'Timeline' do
    let(:conn) { PG.connect(:dbname => ENV['database']) }
    let(:res_red) { conn.exec('select id, username, tweet from tweets where username = $1', ['red']) }
    let(:res_anugrah) { conn.exec('select id, username, tweet from tweets where username = $1', ['anugrah']) }
    let(:tweets) { [] }
    def helper_get_tweets(res)
      res.each do|row|
        tweets << ( row['id'] + " " + row['username'] + " : " + row['tweet'] ) 
      end
      tweets
    end
    context "retaining tweets according to user" do
      it "should retain the dataset of those people wished upon by user" do
        timeline = Timeline.new('anugrah')
        expect(timeline.process).to eq(helper_get_tweets(res_anugrah))
      end

      it "should retain the dataset of those people wished upon by user from database" do
        timeline = Timeline.new('red')
        expect(timeline.process).to eq(helper_get_tweets(res_red))
      end

      it "should give out error if user is not found" do
        timeline = Timeline.new('reggie')
        expect(timeline.process).to eq("No such user exists")
      end

      it "should give out no tweets if user is found but haven't tweeted yet" do
        timeline = Timeline.new('blue')
        expect(timeline.process).to eq("No tweets yet")
      end
    end

    context "equality" do
      it "should be reflexive in nature" do
        timeline_1 = Timeline.new('red')
        expect(timeline_1).to eq(Timeline.new('red'))
      end

      it "should be symmetric in nature" do
        timeline_1 = Timeline.new('red')
        timeline_2 = Timeline.new('red')
        expect(timeline_1).to eq(timeline_2)
        expect(timeline_2).to eq(timeline_1)
      end

      it "should be transitive in nature" do
        timeline_1 = Timeline.new('red')
        timeline_2 = Timeline.new('red')
        timeline_3 = Timeline.new('red')
        expect(timeline_1).to eq(timeline_2)
        expect(timeline_2).to eq(timeline_3)
        expect(timeline_1).to eq(timeline_3)
      end

      it "is not equal to nil" do
        timeline_1 = Timeline.new('red')
        expect(timeline_1).to_not eq(nil)
      end

      it "is not equal for different types" do
        timeline_1 = Timeline.new('red')
        expect(timeline_1).to_not eq(Object.new)
      end

      it "hashes must be same if objects are same" do
        timeline_1 = Timeline.new('red')
        timeline_2 = Timeline.new('red')
        expect(timeline_1.hash).to eq(timeline_2.hash)
      end
    end
  end
end
