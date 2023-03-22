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
    context 'when no part name is provided as a parameter' do
      let!(:assemblies) { create_list(:assembly, 3) }

      before { get :index }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
