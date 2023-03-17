require 'rails_helper'
RSpec.describe AuthorsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { author: { name: 'J.K. Rowling', cpf: CPF.generate } } }

      it 'creates a new author' do
        expect {
          post :create, params: valid_params
        }.to change(Author, :count).by(1)
      end

      it 'returns HTTP status 201 (created)' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'returns the created author as JSON' do
        post :create, params: valid_params
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to include('J.K. Rowling')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { author: { name: nil, cpf: "12345678901234" } } }

      it 'does not create a new author' do
        expect {
          post :create, params: invalid_params
        }.to_not change(Author, :count)
      end

      it 'returns HTTP status 422 (unprocessable entity)' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a JSON with errors' do
        post :create, params: invalid_params
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to include("{\"name\":[\"can't be blank\"],\"cpf\":[\"is invalid\"]}}")
      end
    end
  end
end






