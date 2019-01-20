require 'spec_helper'

RSpec.describe Operations::RateOfReturn do
  let(:initial_value) { 40 }
  let(:final_value)   { 25 }
  describe '#difference' do
    it 'calculates difference' do
      expect(described_class.new(initial_value: initial_value, final_value: final_value).difference).to eq(-15)
    end
  end

  describe '#percent' do
    it 'calculates percent' do
      expected_response = ((final_value - initial_value) / initial_value) * 100
      expect(described_class.new(initial_value: initial_value, final_value: final_value).rate).to eq(expected_response)
    end
  end
end