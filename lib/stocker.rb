require 'stocker/version'
require 'stocker/parse_inputs'

module Stocker
  class Error < StandardError; end
  class CLI
    def self.start(args)
      api_key, ticker, from_date, to_date = ParseInputs.new(
        ENV['API_KEY'],
        args
      ).call
    end
  end
end
