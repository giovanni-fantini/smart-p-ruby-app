# frozen_string_literal: true

RSpec.describe LogHandler::Parser::Base do
  describe '.call' do
    context 'when an invalid filepath is given' do
      subject { described_class.call('invalid_filepath') { puts 'block given' } }

      it 'raises an ArgumentError' do
        expect { subject }.to raise_error(ArgumentError, 'No file found at path invalid_filepath')
      end
    end

    context 'when a valid filepath is given' do
      subject { described_class.call('spec/fixtures/webserver_fixture.log', col_sep: ' ') { puts 'block given' } }

      it 'raises a NotImplementedError' do
        expect { subject }.to raise_error(NotImplementedError)
      end
    end
  end
end
