require 'rails_helper'

RSpec.describe "Books", type: :request do
  let(:url) { "/books" }

  context "with valid params" do
    let(:book_params) { { book: attributes_for(:book) }.to_json }

    it 'adds a new Book' do
      expect do
        post url, params: book_params
      end.to change(Book, :count).by(1)
    end

    it 'returns last added Book' do
      post url, params: book_params
      expected_book = Book.last.as_json(only: %i(id name))
      expect(body_json['book']).to eq expected_book
    end

    it 'returns success status' do
      post url, params: book_params
      expect(response).to have_http_status(:ok)
    end
  end

  context "with invalid params" do
    let(:book_invalid_params) do
      { book: attributes_for(:book, published_at: nil) }.to_json
    end

    it 'does not add a new Book' do
      expect do
        post url, params: book_invalid_params
      end.to_not change(Book, :count)
    end

    it 'returns error message' do
      post url, params: book_invalid_params
      expect(body_json['errors']['fields']).to have_key('published_at')
    end
  end
end
