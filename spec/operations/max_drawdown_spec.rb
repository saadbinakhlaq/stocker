require 'spec_helper'

RSpec.describe Operations::MaxDrawdown do
  let(:test1) do
    {
      sample: [
        100_000,
        150_000,
        90_000,
        120_000,
        80_000,
        200_000
      ],
      expectation: ((150_000 - 80_000) / 150_000.0 * 100)
    }
  end

  let(:test2) do
    {
      sample: [
        5_000,
        10_000,
        4_000,
        12_000,
        3_000,
        13_000
      ],
      expectation: ((12_000 - 3_000) / 12_000.0 * 100)
    }
  end

  let(:test3) do
    {
      sample: [
        10_000,
        8_000,
        9_000,
        2_000
      ],
      expectation: ((10_000 - 2_000) / 10_000.0 * 100)
    }
  end

  let(:test4) do
    {
      sample: [
        10_000,
        8_000,
        12_000,
        11_000
      ],
      expectation: ((10_000 - 8_000) / 10_000.0 * 100)
    }
  end

  let(:test5) do
    {
      sample: [
        10_000,
        8_000,
        12_000,
        2_000
      ],
      expectation: ((12_000 - 2_000) / 12_000.0 * 100)
    }
  end

  let(:tests) do
    [
      test1,
      test2,
      test3,
      test4,
      test5
    ]
  end

  describe '#calculate' do
    it 'calculates correct max drawdown' do
      tests.each do |test|
        expect(
          described_class.new(test[:sample]).calculate
        ).to eq(test[:expectation])
      end
    end
  end
end