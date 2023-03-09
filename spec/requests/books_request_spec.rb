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
  end
end
