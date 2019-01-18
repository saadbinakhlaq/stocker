require 'spec_helper'

RSpec.describe ParseInputs do
  describe '#verify' do
    it 'raises api_key error if api_key not present' do
      args = ['ticker', '1 Jan 2018']
      expect do
        ParseInputs.new(nil, args).call
      end.to raise_error(ParseInputs::ApiKeyInvalid)
    end

    it 'raise wrong number of arguments if less than 2 arguments is given in args' do
      args = ['ticker']

      expect do
        ParseInputs.new('api_key', args).call
      end.to raise_error(ParseInputs::WrongNumOfArgument)
    end

    it 'raise invalid date if from date is wrong' do
      args = ['ticker', '1']

      expect do
        ParseInputs.new(ENV['GITHUB_API'], args).call
      end.to raise_error(ParseInputs::ApiKeyInvalid)
    end

    it 'raise invalid date if to date is invalid' do
      args = ['ticker', '1 Jan 2018', '1']

      expect do
        ParseInputs.new(ENV['GITHUB_API'], args).call
      end.to raise_error(ParseInputs::ApiKeyInvalid)
    end

    it 'returns api_key, ticker, from_date, and to_date if they are valid' do
      args = ['ticker', 'Jan 1 2018', 'Jan 2 2018']

      expect do
        api_key, ticker, from_date, to_date = ParseInputs.new('api', args).call
        expect(api_key).to_not be_nil
        expect(ticker).to_not be_nil
        expect(from_date).to_not be_nil
        expect(to_date).to_not be_nil
      end.to_not raise_error
    end

    it 'returns api_key, ticker, from_date if they are valid' do
      args = ['ticker', 'Jan 1 2018', 'Jan 2 2018']

      expect do
        api_key, ticker, from_date, to_date = ParseInputs.new('api', args).call
        expect(api_key).to_not be_nil
        expect(ticker).to_not be_nil
        expect(from_date).to_not be_nil
      end.to_not raise_error
    end
  end
end