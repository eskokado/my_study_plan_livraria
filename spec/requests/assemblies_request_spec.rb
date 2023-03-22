require 'rails_helper'

RSpec.describe AssembliesController, type: :request do
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

      let(:valid_attributes) {
        attributes_for(:assembly_with_books)
      }

      it "creates a new Assembly with Books" do
        expect {
          post assemblies_path, params: { assembly: valid_attributes }
        }.to change(Assembly, :count).by(1)
      end

      let(:valid_attributes) {
        attributes_for(:assembly_with_parts_and_books)
      }

      it "creates a new Assembly with Parts and Books" do
        expect {
          post assemblies_path, params: { assembly: valid_attributes }
        }.to change(Assembly, :count).by(1)
      end
    end

    context "with params invalids" do
      let(:invalid_attributes) {
        attributes_for(:assembly_with_parts, name: nil)
      }

      it "does not create a new Assembly with parts" do
        expect {
          post assemblies_path, params: { assembly: invalid_attributes }
        }.to_not change(Author, :count)
      end

      let(:valid_attributes) {
        attributes_for(:assembly_with_books, name: nil)
      }

      it "does not create a new Assembly with book" do
        expect {
          post assemblies_path, params: { assembly: invalid_attributes }
        }.to_not change(Author, :count)
      end

      let(:valid_attributes) {
        attributes_for(:assembly_with_parts_and_books, name: nil)
      }

      it "does not create a new Assembly with parts and book" do
        expect {
          post assemblies_path, params: { assembly: invalid_attributes }
        }.to_not change(Author, :count)
      end
    end
  end

  describe "GET /assemblies" do
    let(:parsed_response) { JSON.parse(response.body) }
    context 'when no part name is provided as a parameter' do
      let!(:assemblies) { create_list(:assembly, 3) }

      before { get assemblies_path }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a list of all assemblies' do
        expect(parsed_response).to match_array(assemblies.as_json)
      end
    end

    context 'when used .with_part_name' do
      it 'returns assemblies with the specified part name' do
        assembly = create(:assembly_with_parts)
        part_with_name = assembly.parts.first

        assembly_with_name = Assembly.with_part_name(part_with_name.name).first

        expect(assembly_with_name).to eq(assembly)
      end
    end
  end
end
