require 'httparty'

module API
  class Quandl
    include HTTParty

    class Error < StandardError; end
    class InvalidDate < Error; end

    base_uri 'www.quandl.com'
    PATH = '/api/v3/datatables/WIKI/PRICES.json'.freeze

    def initialize(api_key, ticker, from_date, to_date = nil)
      @api_key   = api_key
      @ticker    = ticker
      @from_date = from_date
      @to_date   = to_date
    end

    def self.fetch(api_key, ticker:, from_date:, to_date: nil)
      stock_prices_api = new(api_key, ticker, from_date, to_date)
      stock_prices_api.call
    end

    def call
      response = self.class.get(PATH, options)
      raise API::Quandl::Error unless response['quandl_error'].nil?

      response
    end

    private

    def options
      query = {
        api_key: @api_key,
        ticker: @ticker,
        'date.gte' => @from_date,
        'date.lte' => @to_date || Date.today
      }

      { query: query }
    end
  end
end