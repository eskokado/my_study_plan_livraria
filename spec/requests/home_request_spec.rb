require 'rails_helper'

RSpec.describe "Homes", type: :request do
  it "tests home" do
    get '/home'
    expect(body_json).to eq({ 'message' => 'Olá mundo' })
  end

  it "tests home" do
    get '/home'
    expect(response).to have_http_status(:ok)
  end
end
