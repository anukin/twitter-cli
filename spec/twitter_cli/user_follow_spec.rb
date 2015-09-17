require 'spec_helper'

module TwitterCli
  describe "follow" do
    let(:conn) { PG.connect(:dbname => ENV['database']) }

    it "should allow users to follow each other" do
      username = 'anugrah'
      user_to_follow = 'red'
      user_follow = UserFollow.new(conn, username, user_to_follow)
      expect(user_follow.follow).to eq("Successfully followed red")
    end

    it "should allow users to follow valid users" do
      username = 'anugrah'
      user_to_follow = 'munni'
      user_follow = UserFollow.new(conn, username, user_to_follow)
      expect(user_follow.follow).to eq("Pls follow someone who exists")
    end

    it "should allow users to follow users only once" do
      username = 'anugrah'
      user_to_follow = 'red'
      user_follow = UserFollow.new(conn, username, user_to_follow)
      expect(user_follow.follow).to eq("You have already followed this user")
    end
  end
end