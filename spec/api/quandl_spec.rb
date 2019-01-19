require 'spec_helper'

RSpec.describe API::Quandl do
  describe '#fetch' do
    context 'when valid api key is given' do
      let(:api_key)   { '1' }
      let(:ticker)    { 'tocker' }
      let(:from_date) { '1 Jan 2018' }

      subject do
        API::Quandl.fetch(api_key, ticker: ticker, from_date: Date.parse(from_date))
      end

      it 'makes the request with correct params' do
        expect(described_class).to receive(:get).with(
          API::Quandl::PATH,
          query: {
            api_key: api_key,
            ticker: ticker,
            'date.gte' => Date.parse(from_date),
            'date.lte' => Date.today
          }
        ).and_return({})
        subject
      end
    end

    context 'when invalid api key is given' do
      subject do
        API::Quandl.fetch('1', ticker: 'ticker', from_date: '01-02-2018')
      end

      it 'raises invalid api key error' do
        expect do
          subject
        end.to raise_error(API::Quandl::Error)
      end
    end
  end
end