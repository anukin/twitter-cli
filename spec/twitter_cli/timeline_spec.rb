require 'spec_helper'

module TwitterCli
  describe 'TimeLine Access' do
    it "should retain the dataset of those people wished upon by user" do
      timeline = Timeline.new('anugrah')
      expect(timeline.get_tweets).to eq(["hello world indeed", "shine on you crazy diamond"])
    end

    it "should retain the dataset of those people wished upon by user from database" do
      timeline = Timeline.new('red')
      expect(timeline.get_tweets).to eq(["caught a rattata", "shine on you crazy diamond"])
    end
  end
end
