require 'spec_helper'

module TwitterCli
  describe "interface" do
    context "parser" do
      it "should give output based on input" do
        cli = Cli.new
        allow(cli).to receive(:get_name) { 'red' }
        timeline = Timeline.new('red')
        expect(cli.process("timeline")).to eq(timeline)
      end
    end
  end
end
