# frozen_string_literal: true

RSpec.describe LogHandler::Parser::Csv do
  describe '.call' do
    context 'when a parsing block is given' do
      subject do
        described_class.call('spec/fixtures/webserver_fixture.log', col_sep: ' ') do |row, result|
          result[row[0]] = row[1]
          result
        end
      end

      let(:expected_output) do
        {
          '/help_page/1' => '722.247.931.582',
          '/contact' => '184.123.665.067',
          '/home' => '235.313.352.950'
        }
      end

      it 'aggregates the parsed values according to the logic of the given block' do
        expect(subject).to eqexpected_output
      end
    end

    context 'when a parsing block is not given' do
      subject { described_class.call('spec/fixtures/webserver_fixture.log', col_sep: ' ') }

      let(:expected_output) do
        [
          ['/help_page/1', '126.318.035.038'],
          ['/contact', '184.123.665.067'],
          ['/home', '184.123.665.067'],
          ['/help_page/1', '929.398.951.889'],
          ['/help_page/1', '722.247.931.582'],
          ['/home', '235.313.352.950']
        ]
      end

      it 'parses all the csv into an arrary of arrays' do
        expect(subject).to eqexpected_output
      end
    end
  end
end
