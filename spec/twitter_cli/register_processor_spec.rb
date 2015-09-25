require 'spec_helper'

module TwitterCli
  describe RegisterProcessor do
    conn = PG.connect(:dbname => ENV['database'])
    describe '#execute' do
      context 'when user wants to logout' do
        it "should handle the login of valid user" do
          conn.exec('begin')
          register_processor = RegisterProcessor.new(conn)
          allow(register_processor).to receive(:get_name) { 'foo' }
          allow(register_processor).to receive(:get_password) { 'bar' }
          user_interface = UserInterface.new('foo')
          allow(user_interface).to receive(:get_input).and_return('logout')
          register_processor.user_interface = user_interface
          expect(register_processor.execute).to eq("logging out")
          conn.exec('rollback')
        end
      end
    end
  end
end