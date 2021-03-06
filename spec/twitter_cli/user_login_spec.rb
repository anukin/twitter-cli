require 'spec_helper'

module TwitterCli
  describe "Signing in" do
    let(:conn) { PG.connect(:dbname => ENV['database']) }
    context Process do
      it "should let the user sign in according to the name and password and return the user stream" do
        user_login = UserLogin.new(conn, "anugrah", "megamind")
        stream = Stream.new(conn, 'anugrah')
        expect(user_login.process).to eq(stream.get_stream)
      end

      it "should let the user login using valid credentials" do
        user_login = UserLogin.new(conn, "bulla", "gunda")
        expect(user_login.process).to eq("Access denied! No user by that name.")
      end

      it "should not let the user login using arbitrary values" do
        user_login = UserLogin.new(conn, "red", "gunda")
        expect(user_login.process).to eq("Access denied! Check your password.")
      end
    end

    context "equality" do
      it "should be reflexive in nature" do
        user_login_1 = UserLogin.new(conn, 'red','red')
        expect(user_login_1).to eq(UserLogin.new(conn, 'red', 'red'))
      end

      it "should be symmetric in nature" do
        user_login_1 = UserLogin.new(conn, 'red', 'red')
        user_login_2 = UserLogin.new(conn, 'red', 'red')
        expect(user_login_1).to eq(user_login_2)
        expect(user_login_2).to eq(user_login_1)
      end

      it "should be transitive in nature" do
        user_login_1 = UserLogin.new(conn, 'red', 'red')
        user_login_2 = UserLogin.new(conn, 'red', 'red')
        user_login_3 = UserLogin.new(conn, 'red', 'red')
        expect(user_login_1).to eq(user_login_2)
        expect(user_login_2).to eq(user_login_3)
        expect(user_login_1).to eq(user_login_3)
      end

      it "is not equal to nil" do
        user_login_1 = UserLogin.new(conn, 'red', 'red')
        expect(user_login_1).to_not eq(nil)
      end

      it "is not equal for different types" do
        user_login_1 = UserLogin.new(conn, 'red', 'red')
        expect(user_login_1).to_not eq(Object.new)
      end

      it "hashes must be same if objects are same" do
        user_login_1 = UserLogin.new(conn, 'red', 'red')
        user_login_2 = UserLogin.new(conn, 'red', 'red')
        expect(user_login_1.hash).to eq(user_login_2.hash)
      end
    end
  end
end
