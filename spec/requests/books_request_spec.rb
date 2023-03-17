require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe "#create" do
    context "with params valids" do
      let(:author) { create(:author) }
      let(:book_params) { attributes_for(:book, author_id: author.id, isbn: Faker::Code.isbn(base: 13)) }

      it "create new an book" do
        expect {
          post :create, params: { book: book_params }
        }.to change(Book, :count).by(1)
      end

      it "return status created" do
        post :create, params: { book: book_params }
        expect(response).to have_http_status(:created)
      end

      it "return given of book created" do
        post :create, params: { book: book_params }
        expect(response.body).to include(book_params[:published_at].to_s)
      end
    end

    context "with params invalids" do
      let(:book_params) { attributes_for(:book, published_at: nil, isbn: nil) }

      it "does not create a new book" do
        expect {
          post :create, params: { book: book_params }
        }.not_to change(Book, :count)
      end

      it "return status :unprocessable_entity" do
        post :create, params: { book: book_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns an errors of validation" do
        post :create, params: { book: book_params }
        expect(response.body).to include("{\"errors\":{\"published_at\":[\"can't be blank\"],\"isbn\":[\"can't be blank\"],\"author\":[\"must exist\"]}}")
      end
    end
  end
end

