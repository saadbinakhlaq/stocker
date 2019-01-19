require 'stocker/version'
require 'stocker/parse_inputs'
require 'stocker/api/quandl'
require 'stocker/response_builder'

module Stocker
  class Error < StandardError; end
  class CLI
    def self.start(args)
      api_key, ticker, from_date, to_date = ParseInputs.new(
        ENV['API_KEY'],
        args
      ).call

      api_response = API::Quandl.fetch(
        api_key,
        ticker: ticker,
        from_date: from_date,
        to_date: to_date
      )

      response = ResponseBuilder.new(api_response).response
    end
  end
end
