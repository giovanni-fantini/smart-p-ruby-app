# frozen_string_literal: true

RSpec.describe LogHandler::ViewsCounter do
  describe '.call' do
    subject { described_class.call(row: row, result: result) }

    let(:row) do
      ['/home', '235.313.352.950']
    end

    context 'when the page already had a previous view' do
      let(:result) do
        {
          '/help_page/1' => {
            '126.318.035.038' => 2,
            '929.398.951.889' => 1
          },
          '/contact' => {
            '184.123.665.067' => 1
          },
          '/home' => {
            '184.123.665.067' => 1
          }
        }
      end

      let(:expected_result) do
        {
          '/help_page/1' => {
            '126.318.035.038' => 2,
            '929.398.951.889' => 1
          },
          '/contact' => {
            '184.123.665.067' => 1
          },
          '/home' => {
            '184.123.665.067' => 1,
            '235.313.352.950' => 1
          }
        }
      end

      it 'aggregates the given page view by ip into the hash of previous views' do
        expect(subject).to eq(expected_result)
      end
    end

    context 'when the page did not have previous views' do
      let(:result) do
        {
          '/help_page/1' => {
            '126.318.035.038' => 2,
            '929.398.951.889' => 1
          },
          '/contact' => {
            '184.123.665.067' => 1
          }
        }
      end

      let(:expected_result) do
        {
          '/help_page/1' => {
            '126.318.035.038' => 2,
            '929.398.951.889' => 1
          },
          '/contact' => {
            '184.123.665.067' => 1
          },
          '/home' => {
            '235.313.352.950' => 1
          }
        }
      end

      it 'aggregates the given page view by ip into the hash of previous views' do
        expect(subject).to eq(expected_result)
      end
    end
  end
end
