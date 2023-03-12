require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe "#create" do
    context "with params valids" do
      let(:author) { create(:author) }
      let(:book_params) { attributes_for(:book, author_id: author.id) }

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
  end
end
