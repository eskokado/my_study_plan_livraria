require 'rails_helper'

RSpec.describe PartsController, type: :controller do
  let!(:supplier) { create(:supplier) }

  describe "POST #create" do
    context "with valid params" do
      let(:supplier) { create(:supplier) }
      let(:book) { create(:book_with_parts) }
      let(:part_attributes) { attributes_for(:part, value: 100, supplier: supplier, book: book) }

      it "creates a new Part" do
        expect {
          post :create, params: { supplier_id: supplier.id, book_id: book.id, part: part_attributes }
        }.to change(Part, :count).by(3)
      end

      it "returns a success response with JSON body" do
        post :create, params: { supplier_id: supplier.id, book_id: book.id, part: part_attributes }
        puts response.body
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)['part']['part_number']).to eq(part_attributes[:part_number])
        expect(JSON.parse(response.body)['part']['supplier_id']).to eq(supplier.id)
      end
    end

    context "with invalid params" do
      let(:supplier) { create(:supplier) }
      let(:book) { create(:book_with_parts) }
      let(:invalid_attributes) { { part_number: nil } }

      it "does not create a new Part" do
        expect {
          post :create, params: { supplier_id: supplier.id, book_id: book.id, part: invalid_attributes }
        }.to change(Part, :count).by(2)
      end

      it "returns an unprocessable_entity response with JSON body" do
        post :create, params: { supplier_id: supplier.id, book_id: book.id, part: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)['errors']['part_number']).to include("can't be blank")
      end
    end
  end
end
