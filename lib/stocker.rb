# frozen_string_literal: true

require 'stocker/version'
require 'stocker/parse_inputs'
require 'stocker/api/quandl'
require 'stocker/response_builder'
require 'stocker/operations/rate_of_return'
require 'stocker/operations/max_drawdown'
require 'stocker/output_formatter'

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

      response = ResponseBuilder.new(api_response)

      if response.records?
        first_open_value     = response.collection.first.open
        last_adj_close_value = response.collection.last.adj_close

        rate_of_return = Operations::RateOfReturn.new(
          initial_value: first_open_value,
          final_value:   last_adj_close_value
        )
        percent    = rate_of_return.rate
        difference = rate_of_return.difference

        values = []
        values << response.collection.first.open
        response.collection.each do |data|
          values << data.high
          values << data.low
        end
        values << response.collection.last.close

        max_drawdown = Operations::MaxDrawdown.new(values).calculate

        OutputFormatter.display_stock_prices(response.collection)
        OutputFormatter.display_max_drawdown(max_drawdown)
        OutputFormatter.display_rate_of_return(difference, percent)
      else
        puts "No record found for #{ticker}"
      end

    rescue ParseInputs::WrongNumOfArgument
      puts <<~ARGS
        Wrong number of arguments given
        Usage: API_KEY=api_key stocker ASDAPL '2 Jan 2018' '5 Jan 2018'
               OR
               API_KEY=api_key stocker ASDAPL '2 Jan 2018'
      ARGS
    rescue ParseInputs::ApiKeyInvalid
      puts <<~API
        Api key not given
        Usage: API_KEY=api_key stocker ASDAPL '2 Jan 2018' '5 Jan 2018'
               OR
               API_KEY=api_key stocker ASDAPL '2 Jan 2018'
      API
    rescue ParseInputs::InvalidDate
      puts <<~DATE
        Date is invalid format
        Add date in '1 Jan 2018' format
      DATE
    end
  end
end
