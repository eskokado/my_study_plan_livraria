require 'rails_helper'

RSpec.describe PartsController, type: :controller do
  let!(:supplier) { create(:supplier) }

  describe "POST #create" do
    context "with valid params" do
      let(:part_attributes) { attributes_for(:part) }

      it "creates a new Part" do
        expect {
          post :create, params: { supplier_id: supplier.id, part: part_attributes }
        }.to change(Part, :count).by(1)
      end

      it "returns a success response with JSON body" do
        post :create, params: { supplier_id: supplier, part: part_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)['part']['part_number']).to eq(part_attributes[:part_number])
        expect(JSON.parse(response.body)['part']['supplier_id']).to eq(supplier.id)
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { { part_number: nil }}

      it "does not create a new Part" do
        expect {
          post :create, params: { supplier_id: supplier.id, part: invalid_attributes }
        }.to_not change(Part, :count)
      end
    end
  end
end
