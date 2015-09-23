require 'spec_helper'

module TwitterCli
  describe "follow" do
    before(:all) do
      @conn = PG.connect(:dbname => ENV['database'])
    end
    it "should allow users to follow each other" do
      @conn.exec('begin')
      username = 'anugrah'
      user_to_follow = 'blue'
      user_follow = UserFollow.new(@conn, username, user_to_follow)
      expect(user_follow.follow).to eq("Successfully followed blue")
      @conn.exec('rollback')
    end

    it "should allow users to follow users only once" do
      @conn.exec('begin')
      username = 'anugrah'
      user_to_follow = 'red'
      user_follow = UserFollow.new(@conn, username, user_to_follow)
      expect(user_follow.follow).to eq("You have already followed this user")
      @conn.exec('rollback')
    end

    it "should allow users to follow valid users" do
      username = 'anugrah'
      user_to_follow = 'munni'
      user_follow = UserFollow.new(@conn, username, user_to_follow)
      expect(user_follow.follow).to eq("Pls follow someone who exists")
    end
  end
end