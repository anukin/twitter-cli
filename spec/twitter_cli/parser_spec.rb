require 'spec_helper'

module TwitterCli
  describe "Parser" do
    context "parsing" do
      it "should parse according to the inputs" do
        parser = Parser.new('timeline', 'red')
        expect(parser.parse).to eq(Timeline.new('red'))
      end

      it "should parse according to the inputs" do
        parser = Parser.new('help')
        expect(parser.parse).to eq(:help)
      end
    end
  end
end
