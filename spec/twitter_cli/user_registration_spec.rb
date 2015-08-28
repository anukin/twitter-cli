require 'spec_helper'

module TwitterCli
  describe "User registration" do
    let(:conn) { PG.connect(:dbname => ENV['database']) }
    context "registration" do
      it "should allow users to register for the application" do
        user = 'blue'
        password = 'catch them all'
        user_registration = UserRegistration.new(user, password)
        user_registration.register
        res = conn.exec('select user from users where name = $1', [user])
        expect(res.ntuples).to_not eq(0)
      end

      it "if user is already present then it should return error message" do
        user = 'red'
        password = 'catch them all'
        user_registration = UserRegistration.new(user, password)
        expect(user_registration.register).to eq("Another user exists with same name pls go for some other username!")
      end
    end
  end
end
