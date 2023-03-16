require 'rails_helper'

RSpec.describe "Assemblies", type: :request do
  describe "POST /assemblies" do
    context "with valid params" do
      let(:valid_attributes) {
        attributes_for(:assembly_with_parts)
      }

      it "creates a new Assembly with Parts" do
        expect {
          post assemblies_path, params: { assembly: valid_attributes }
        }.to change(Assembly, :count).by(1)
      end
    end

  end
end


