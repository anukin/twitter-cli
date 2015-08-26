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
    end
  end
end
