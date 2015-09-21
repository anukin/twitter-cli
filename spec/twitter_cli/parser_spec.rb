require 'spec_helper'

module TwitterCli
  describe "Parser" do
    context "parsing" do
      let(:conn) { PG.connect(:dbname => ENV['database']) }
      it "should parse according to the inputs" do
        parser = Parser.new(conn, 'timeline', 'red')
        expect(parser.parse).to eq(Timeline.new(conn, 'red'))
      end

      it "should parse according to the inputs" do
        parser = Parser.new(conn, 'register', 'lol', 'lol')
        expect(parser.parse).to eq(UserRegistration.new(conn, 'lol', 'lol'))
      end

      it "should parse according to the inputs" do
        parser = Parser.new(conn, 'login', 'bulla', 'gunda')
        expect(parser.parse).to eq(UserLogin.new(conn, 'bulla', 'gunda'))
      end
    end
  end
end
