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
    end
  end
end
