require 'rails_helper'

RSpec.describe "Authors", type: :request do
  let(:url) { "/authors" }

  context "with valid params" do
    let(:author_params) { { author: attributes_for(:author) } }

    it 'adds a new Author' do
      expect do
        post url, params: author_params
      end.to change(Author, :count).by(1)
    end

    it 'returns last added Author' do
      post url, params: author_params
      expected_author = Author.last.as_json(only: %i(id name))
      expect(body_json['author']).to eq expected_author
    end

    it 'returns success status' do
      post url, params: author_params
      expect(response).to have_http_status(:created)
    end
  end

  context "with invalid params" do
    let(:author_invalid_params) do
      { author: attributes_for(:author, name: nil) }.to_json
    end

    it 'does not add a new Author' do
      expect do
        post url, params: author_invalid_params
      end.to_not change(Author, :count)
    end

    it 'returns error message' do
      post url, params: author_invalid_params
      expect(body_json['errors']['fields']).to have_key('name')
    end

    it 'returns unprocessable_entity status' do
      post url, params: author_invalid_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
