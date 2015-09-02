require 'spec_helper'

module TwitterCli
  describe "unfollow" do
    let(:conn) { PG.connect(:dbname => ENV['database']) }

    it "should allow users to unfollow each other" do
      username = 'anugrah'
      user_to_unfollow = 'red'
      user_unfollow = UserUnfollow.new(username, user_to_unfollow)
      expect(user_unfollow.unfollow).to eq("Successfully unfollowed red")
    end

    it "should allow users to unfollow valid users" do
      username = 'anugrah'
      user_to_unfollow = 'moi'
      user_unfollow = UserUnfollow.new(username, user_to_unfollow)
      expect(user_unfollow.unfollow).to eq("Pls unfollow someone who exists")
    end
  end
end