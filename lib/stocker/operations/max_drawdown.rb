# frozen_string_literal: true

module Operations
  class MaxDrawdown
    attr_reader :values

    def initialize(values)
      @values = values.dup
    end

    def calculate
      ((largest_drop.max - largest_drop.min) / Float(largest_drop.max)) * 100
    end

    private

    # rubocop:disable Style/MultilineBlockChain
    def largest_drop
      @largest_drop ||= peak_to_peak_values.map do |peak_to_peak|
        Range.new(*peak_to_peak.minmax)
      end.max_by { |range| range.max - range.min }
    end
    # rubocop:enable Style/MultilineBlockChain

    def peak_to_peak_values
      peak_to_peak_values = []
      tmp_values = values.dup

      peak_to_peak_values << tmp_values.slice!(
        tmp_values.index(tmp_values.max)..-1
      ) until tmp_values.empty?

      peak_to_peak_values.reverse
    end
  end
end
