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
    end
  end
end
