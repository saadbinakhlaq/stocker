# Stocker
This is a gem that makes it possible to access stock information via command line. You can provide [stock symbol](https://en.wikipedia.org/wiki/Ticker_symbol) and start and end date. It requires (Quandl)[https://www.quandl.com/databases/WIKIP] api key, it uses quandl's wiki prices api to access stock information. It calculates [max drawdown](https://ycharts.com/glossary/terms/max_drawdown) and [rate of return](https://en.wikipedia.org/wiki/Rate_of_return#Return)


## Installation
install it as:

    $ bin/setup

## Usage

    $ API_KEY=api_key stocker AAPL '1 Jan 2018' '5 Jan 2018'

    AAPL is a stock symbol
    '1 Jan 2018' is start date
    '5 Jan 2018' end date

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
