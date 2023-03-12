require 'rails_helper'
RSpec.describe AuthorsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { author: { name: 'J.K. Rowling' } } }

      it 'creates a new author' do
        expect {
          post :create, params: valid_params
        }.to change(Author, :count).by(1)
      end

      it 'returns HTTP status 201 (created)' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end
  end
end


