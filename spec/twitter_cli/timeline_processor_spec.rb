require 'spec_helper'

module TwitterCli
  describe "timeline processor" do
    conn = PG.connect(:dbname => ENV['database'])
    context "execute" do
      it "should process based on username" do
        conn.exec('begin')
        timeline_processor = TimelineProcessor.new(conn)
        allow(timeline_processor).to receive(:get_name) { 'red' }
        expect(timeline_processor.execute).to eq(Timeline.new(conn, 'red').process)
        conn.exec('rollback')
      end
    end
  end
end
