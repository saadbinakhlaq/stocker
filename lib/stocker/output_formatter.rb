# frozen_string_literal: true

class OutputFormatter
  def self.display_stock_prices(values)
    values.each do |value|
      display_price_data(value)
    end
  end

  def self.display_rate_of_return(difference, percent)
    puts "Return: #{difference} [#{display_percent(percent.round(1))} %]"
  end

  def self.display_max_drawdown(max_drawdown)
    puts "Maximum Drawdown: #{display_percent(max_drawdown.round(1))} %"
  end

  def self.display_price_data(value)
    # rubocop:disable Metrics/LineLength
    puts "#{value.date.strftime('%d.%m.%Y')}: Closed at #{value.close} (#{value.high} ~ #{value.low})"
    # rubocop:enable Metrics/LineLength
  end

  def self.display_percent(percent)
    percent.positive? ? "+#{percent}" : percent
  end
end
