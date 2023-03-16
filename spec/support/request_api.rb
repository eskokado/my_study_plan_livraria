module RequestAPI
  def body_json(symbolize_keys: false)
    json = JSON.parse(response.body)
    symbolize_keys ? json.deep_symbolize_keys : json
  rescue
    return {}
  end
end

RSpec.configure do |config|
  config.include RequestAPI, type: :request
end
