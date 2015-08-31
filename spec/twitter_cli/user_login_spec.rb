require 'spec_helper'

module TwitterCli
  describe "User Signing in" do
    let(:conn) { PG.connect(:dbname => ENV['database']) }
    context "signing in" do
      it "should let the user sign in according to the name and password" do
        user_login = UserLogin.new("anugrah", "megamind")
        expect(user_login.login).to eq("Successfully logged in!")
      end
    end
  end
end
