RSpec.describe LogHandler::ViewsCalculator do
  describe '.call' do
    subject { described_class.call(views: views, mode: mode) }

    let(:views) do
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

    context 'when an unrecognized mode is given' do
      let(:mode) { 'something' }

      it 'raises an UnacceptedModeError' do
        expect{subject}.to raise_error(LogHandler::UnacceptedModeError, 'The specified mode is invalid - currently accepted modes [:total, :unique]')
      end
    end

    context 'when the mode is :total' do
      let(:mode) { :total }
      let(:expected_result) do
        [
          ['/help_page/1', 3],
          ['/contact', 1],
          ['/home', 2]
        ]
      end

      it 'calculates the total views per page' do
        expect(subject).to eq (expected_result)
      end
    end

    context 'when the mode is :unique' do
      let(:mode) { :unique }
      let(:expected_result) do
        [
          ['/help_page/1', 2],
          ['/contact', 1],
          ['/home', 2]
        ]
      end

      it 'calculates the total views per page' do
        expect(subject).to eq (expected_result)
      end
    end
  end
end