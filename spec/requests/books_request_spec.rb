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

  end
end
