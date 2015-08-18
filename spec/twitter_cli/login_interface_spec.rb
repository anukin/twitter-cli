require 'spec_helper'

module TwitterCli
  describe "login interface" do
    context "logging in as existing user" do
      it "should allow valid user to be logged in" do
        login_interface = LoginInterface.new("anugrah", "lol")
        expect(login_interface.login).to eq("successfully logged in")
      end
    end
  end
end
