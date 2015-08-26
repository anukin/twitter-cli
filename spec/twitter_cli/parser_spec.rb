require 'spec_helper'

module TwitterCli
  describe "Parser" do
    context "parsing" do
      it "should parse according to the inputs" do
        parser = Parser.new('timeline')
        allow(parser).to receive(:gets).and_return('red')
        allow(parser).to receive(:puts).and_return("Pls give me the name of user whose timeline you wish to access? \n")
        expect(parser.parse).to eq(Timeline.new('red'))
      end
    end
  end
end
