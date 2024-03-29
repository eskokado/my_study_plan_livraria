require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe "#create" do
    context "with params valids" do
      let(:author) { create(:author) }
      let(:book_params) { attributes_for(:book, author_id: author.id, isbn: Faker::Code.isbn(base: 13), title: Faker::Book.title) }

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
        expect(response.body).to include("can't be blank" || "must exist")
      end
    end
  end

  describe "GET /books" do
    let(:parsed_response) { JSON.parse(response.body) }
    context 'when no title is provided as a parameter' do
      let!(:books) { create_list(:book, 3) }

      before { get :index }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a list of all books in descending order of publication date' do
        expect(parsed_response).to match_array(books.as_json)
      end
    end

    context 'when a title is provided as a parameter' do
      let(:matching_title) { 'The Lord of the Rings' }
      let(:not_matching_title) { 'Harry Potter' }
      let!(:book_matching_title) { create(:book, title: matching_title) }
      let!(:book_not_matching_title) { create(:book, title: not_matching_title) }

      before { get :index, params: { title: matching_title } }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns only books that match the provided title' do
        expect(parsed_response).to match_array([book_matching_title.as_json])
      end

      it 'does not return books that do not match the provided title' do
        expect(parsed_response).not_to include(book_not_matching_title.as_json)
      end
    end

    context 'when no author name is provided as a parameter' do
      let!(:books) { create_list(:book, 3) }

      before { get :index }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a list of all books in descending order of publication date' do
        expect(parsed_response).to match_array(books.as_json)
      end
    end

    context 'when a author name is provided as a parameter' do
      let(:author_name) { 'John Smith' }
      let(:not_author_name) { 'Jane Doe' }
      let!(:book_author_name) { create(:book, title: author_name) }
      let!(:book_not_author_name) { create(:book, title: not_author_name) }

      before { get :index, params: { title: author_name } }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns only books that match the provided author name' do
        expect(parsed_response).to match_array([book_author_name.as_json])
      end

      it 'does not return books that do not match the provided author name' do
        expect(parsed_response).not_to include(book_not_author_name.as_json)
      end
    end
  end

  describe 'GET #get_book_with_assembly_parts_and_costs' do
    let!(:book) { create(:book) }
    let!(:assembly) { create(:assembly_with_parts_and_books, associated_books: [book]) }

    before do
      get :get_book_with_assembly_parts_and_costs, params: { id: book.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the correct book, assembly, total parts and total cost' do
      json_response = JSON.parse(response.body)
      expect(json_response['book']['id']).to eq(book.id)
      expect(json_response['assembly']['id']).to eq(assembly.id)
      expect(json_response['total_parts']).to eq(assembly.parts.count)
      expect(json_response['total_cost'].to_f).to eq(assembly.parts.sum(:value))
    end
  end
end

