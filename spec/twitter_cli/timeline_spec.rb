require 'spec_helper'

module TwitterCli
  describe 'TimeLine Access' do
    context "retaining tweets according to user" do
      it "should retain the dataset of those people wished upon by user" do
        timeline = Timeline.new('anugrah')
        expect(timeline.get_tweets).to eq(["hello world indeed", "shine on you crazy diamond"])
      end

      it "should retain the dataset of those people wished upon by user from database" do
        timeline = Timeline.new('red')
        expect(timeline.get_tweets).to eq(["caught a rattata", "shine on you crazy diamond"])
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
