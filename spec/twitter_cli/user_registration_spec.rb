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

      it "should return the UserRegistration of user once he's finished registering" do
        user = 'lol'
        password = 'lol'
        user_registration = UserRegistration.new(user, password)
        timeline = Timeline.new('lol')
        expect(user_registration.register).to eq(timeline.get_tweets)
      end
    end

    context "equality" do
      it "should be reflexive in nature" do
        user_registration_1 = UserRegistration.new('red','red')
        expect(user_registration_1).to eq(UserRegistration.new('red', 'red'))
      end

      it "should be symmetric in nature" do
        user_registration_1 = UserRegistration.new('red', 'red')
        user_registration_2 = UserRegistration.new('red', 'red')
        expect(user_registration_1).to eq(user_registration_2)
        expect(user_registration_2).to eq(user_registration_1)
      end

      it "should be transitive in nature" do
        user_registration_1 = UserRegistration.new('red', 'red')
        user_registration_2 = UserRegistration.new('red', 'red')
        user_registration_3 = UserRegistration.new('red', 'red')
        expect(user_registration_1).to eq(user_registration_2)
        expect(user_registration_2).to eq(user_registration_3)
        expect(user_registration_1).to eq(user_registration_3)
      end

      it "is not equal to nil" do
        user_registration_1 = UserRegistration.new('red', 'red')
        expect(user_registration_1).to_not eq(nil)
      end

      it "is not equal for different types" do
        user_registration_1 = UserRegistration.new('red', 'red')
        expect(user_registration_1).to_not eq(Object.new)
      end

      it "hashes must be same if objects are same" do
        user_registration_1 = UserRegistration.new('red', 'red')
        user_registration_2 = UserRegistration.new('red', 'red')
        expect(user_registration_1.hash).to eq(user_registration_2.hash)
      end
    end
  end
end
