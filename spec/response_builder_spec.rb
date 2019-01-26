# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResponseBuilder do
  describe '#records?' do
    context 'when response has data collection' do
      subject do
        ResponseBuilder.new(
          'datatable' => {
            'data' => [{}]
          }
        ).records?
      end

      it { should be_truthy }
    end

    context 'when response does not have data collection' do
      subject do
        ResponseBuilder.new(
          'datatable' => {
            'data' => []
          }
        ).records?
      end

      it { should be_falsey }
    end
  end

  describe '#collection' do
    context 'when data collection is present' do
      let(:api_response) do
        {
          'datatable' => {
            'data' => [
              [
                'AAPL',
                '2018-03-27',
                173.68,
                175.15,
                166.92,
                168.34,
                38.0,
                0.0,
                1.0,
                173.68,
                175.15,
                166.92,
                168.34,
                38.0
              ]
            ]
          }
        }
      end

      subject do
        ResponseBuilder.new(api_response).collection.first
      end

      it { should be_instance_of(ResponseBuilder::Response) }

      it 'should have the valid response' do
        response = subject

        expect(response.ticker).to eq(api_response['datatable']['data'].first[0])
        expect(response.open).to eq(api_response['datatable']['data'].first[2])
      end
    end

    context 'when data collection is not present' do
      subject do
        ResponseBuilder.new(
          'datatable' => {
            'data' => []
          }
        ).collection
      end

      it { should eq([]) }
    end
  end
end