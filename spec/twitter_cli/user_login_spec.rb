require 'spec_helper'

module TwitterCli
  describe "User Signing in" do
    let(:conn) { PG.connect(:dbname => ENV['database']) }
    context "signing in" do
      it "should let the user sign in according to the name and password" do
        user_login = UserLogin.new("anugrah", "megamind")
        timeline = Timeline.new('anugrah')
        expect(user_login.process).to eq(timeline.process)
      end

      it "should let the user login using valid credentials" do
        user_login = UserLogin.new("bulla", "gunda")
        expect(user_login.process).to eq("Access denied! No user by that name.")
      end

      it "should not let the user login using arbitrary values" do
        user_login = UserLogin.new("red", "gunda")
        expect(user_login.process).to eq("Access denied! Check your password.")
      end
    end

    context "equality" do
      it "should be reflexive in nature" do
        user_login_1 = UserLogin.new('red','red')
        expect(user_login_1).to eq(UserLogin.new('red', 'red'))
      end

      it "should be symmetric in nature" do
        user_login_1 = UserLogin.new('red', 'red')
        user_login_2 = UserLogin.new('red', 'red')
        expect(user_login_1).to eq(user_login_2)
        expect(user_login_2).to eq(user_login_1)
      end

      it "should be transitive in nature" do
        user_login_1 = UserLogin.new('red', 'red')
        user_login_2 = UserLogin.new('red', 'red')
        user_login_3 = UserLogin.new('red', 'red')
        expect(user_login_1).to eq(user_login_2)
        expect(user_login_2).to eq(user_login_3)
        expect(user_login_1).to eq(user_login_3)
      end

      it "is not equal to nil" do
        user_login_1 = UserLogin.new('red', 'red')
        expect(user_login_1).to_not eq(nil)
      end

      it "is not equal for different types" do
        user_login_1 = UserLogin.new('red', 'red')
        expect(user_login_1).to_not eq(Object.new)
      end

      it "hashes must be same if objects are same" do
        user_login_1 = UserLogin.new('red', 'red')
        user_login_2 = UserLogin.new('red', 'red')
        expect(user_login_1.hash).to eq(user_login_2.hash)
      end
    end
  end
end
