require 'spec_helper'

module TwitterCli
  describe "Parser" do
    context "parsing" do
      it "should parse according to the inputs" do
        parser = Parser.new('timeline')
        expect(parser.parse). to eq(Timeline.new('red'))
      end
    end
  end
end
