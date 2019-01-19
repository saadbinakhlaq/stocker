class ResponseBuilder
  attr_reader :api_response

  Response = Struct.new(
    :ticker,
    :date,
    :open,
    :high,
    :low,
    :close,
    :volume,
    :ex_dividend,
    :split_ratio,
    :adj_open,
    :adj_high,
    :adj_low,
    :adj_close,
    :adj_volume
  )

  def initialize(api_response)
    @api_response = api_response
  end

  def has_records?
    api_response['datatable']['data'].size > 0
  end

  def collection
    if has_records?
      list_of_data.map do |each_data|
        Response.new(
          each_data[0],
          Date.parse(each_data[1]),
          each_data[2],
          each_data[3],
          each_data[4],
          each_data[5],
          each_data[6],
          each_data[7],
          each_data[8],
          each_data[9],
          each_data[10],
          each_data[11],
          each_data[12],
          each_data[13]
        )
      end
    else
      []
    end
  end

  private

  def list_of_data
    api_response['datatable']['data']
  end
end