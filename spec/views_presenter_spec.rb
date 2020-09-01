# frozen_string_literal: true

RSpec.describe LogHandler::ViewsPresenter do
  describe '.call' do
    subject { described_class.call(views: views, mode: mode) }

    context 'when an unrecognized mode is given' do
      let(:mode) { 'something' }

      it 'raises an UnacceptedModeError' do
        expect { subject }.to raise_error(
          LogHandler::UnacceptedModeError,
          'The specified mode is invalid - currently accepted modes [:total, :unique]'
        )
      end
    end

    context 'when the mode is :total' do
      let(:mode) { :total }
      let(:views) do
        [
          ['/help_page/1', 3],
          ['/contact', 1],
          ['/home', 2]
        ]
      end
      let(:expected_result) do
        %r{
          Report on total page views
          Page         | Total Views
          /help_page/1 | 3
          /home        | 2
          /contact     | 1
        }x
      end

      it 'outputs the sorted list of total page views to STDOUT' do
        expect { subject }.to output(expected_result).to_stdout
      end
    end

    context 'when the mode is :unique' do
      let(:mode) { :unique }
      let(:views) do
        [
          ['/help_page/1', 2],
          ['/contact', 1],
          ['/home', 2]
        ]
      end
      let(:expected_result) do
        %r{
          Report on unique page views
          Page         | Unique Views
          /help_page/1 | 2
          /home        | 2
          /contact     | 1
        }x
      end

      it 'outputs the sorted list of unique page views to STDOUT' do
        expect { subject }.to output(expected_result).to_stdout
      end
    end
  end
end
