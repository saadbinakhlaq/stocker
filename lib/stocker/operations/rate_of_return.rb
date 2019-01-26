# frozen_string_literal: true

module Operations
  class RateOfReturn
    def initialize(initial_value:, final_value:)
      @initial_value = initial_value
      @final_value   = final_value
    end

    def rate
      (difference / @initial_value) * 100
    end

    def difference
      @final_value - @initial_value
    end
  end
end
