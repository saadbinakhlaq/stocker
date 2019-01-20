require 'spec_helper'

RSpec.describe Operations::MaxDrawdown do
  describe '#calculate' do
    let(:values) do
      [
        100_000,
        150_000,
        90_000,
        120_000,
        80_000,
        200_000
      ]
    end

    it 'calculates max drawdown' do
      a = described_class.new(values).calculate
      expect(a).to eq(46.666666666666664)
    end
  end
end