require 'date'

class ParseInputs
  class Error < StandardError; end
  class ApiKeyInvalid < Error; end
  class InvalidDate < Error; end
  class WrongNumOfArgument < Error; end

  def initialize(api_key, args)
    @api_key = api_key
    @args    = args
  end

  def call
    raise ParseInputs::ApiKeyInvalid if @api_key.nil?
    raise ParseInputs::WrongNumOfArgument if @args.size < 2

    ticker = @args[0]
    from_date = Date.parse(@args[1])

    if @args.length == 3
      to_date = Date.parse(@args[2])
      [@api_key, ticker, from_date, to_date]
    else

      [@api_key, ticker, from_date]
    end
  rescue ArgumentError
    raise ParseInputs::InvalidDate
  end
end