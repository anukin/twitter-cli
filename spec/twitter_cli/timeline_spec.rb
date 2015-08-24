require 'spec_helper'

module TwitterCli
  describe 'TimeLine Access' do
    it "should retain the dataset of those people wished upon by user" do
      timeline = Timeline.new("anugrah")
      expect(timeline.get_tweets).to eq({:user => "anugrah", :tweet => "hello world indeed"})
    end
  end
end
