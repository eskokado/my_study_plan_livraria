require 'rails_helper'

RSpec.describe "Suppliers", type: :request do
  let(:url) { "/suppliers" }

  describe "POST #create" do
    context "with params valids" do
      let(:supplier_params) { attributes_for(:supplier, cnpj: CNPJ.generate) }
      let(:account_params) { attributes_for(:account, account_number: "123456", verifier_digit: "7") }
      let(:valid_params) { { supplier: supplier_params, account: account_params } }

      it "create an new suppliers with an new account" do
        expect do
          post url, params: valid_params
        end.to change(Supplier, :count).by(1).and change(Account, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to include(supplier_params[:name], account_params[:account_number])
      end
    end

    context "with params invalids" do
      let(:supplier_params) { attributes_for(:supplier, name: "", cpnj: "12345678901234") }
      let(:account_params) { attributes_for(:account, account_number: "", verifier_digit: "") }
      let(:invalid_params) { { supplier: supplier_params, account: account_params } }

      it "return an error no process" do
        post url, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to include("can't be blank")
      end
    end
  end
end
