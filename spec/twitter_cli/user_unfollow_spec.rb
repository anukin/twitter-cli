require 'spec_helper'

module TwitterCli
  describe "unfollow" do
    conn = PG.connect(:dbname => ENV['database'])

    it "should allow users to unfollow each other" do
      conn.exec('begin')
      username = 'anugrah'
      user_to_unfollow = 'red'
      user_unfollow = UserUnfollow.new(conn, username, user_to_unfollow)
      user_follow = UserFollow.new(conn, username, user_to_unfollow)
      user_follow.follow
      expect(user_unfollow.unfollow).to eq("Successfully unfollowed red")
    end

    it "should allow users to unfollow users which user is following" do
      username = 'anugrah'
      user_to_unfollow = 'lol'
      user_unfollow = UserUnfollow.new(conn, username, user_to_unfollow)
      expect(user_unfollow.unfollow).to eq("You do not follow this user")
      conn.exec('rollback')
    end
    
    it "should allow users to unfollow valid users" do
      username = 'anugrah'
      user_to_unfollow = 'moi'
      user_unfollow = UserUnfollow.new(conn, username, user_to_unfollow)
      expect(user_unfollow.unfollow).to eq("Pls unfollow someone who exists")
    end
  end
end