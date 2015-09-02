require 'spec_helper'

module TwitterCli
  describe "follow" do
    let(:conn) { PG.connect(:dbname => ENV['database']) }

    it "should allow users to follow each other" do
      username = 'anugrah'
      user_to_follow = 'red'
      user_follow = UserFollow.new(username, user_to_follow)
      expect(user_follow.follow).to eq("Successfully followed red")
    end
  end
end