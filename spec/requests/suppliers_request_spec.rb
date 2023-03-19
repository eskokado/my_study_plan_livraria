require 'rails_helper'

RSpec.describe "SuppliersController", type: :request do
  let(:url) { "/suppliers" }

  describe "POST #create" do
    context "with params valids" do
      let(:supplier_params) { attributes_for(:supplier, cnpj: CNPJ.generate) }
      let(:account_params) { attributes_for(:account) }
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
      let(:supplier_params) { attributes_for(:supplier, name: "", cnpj: "12345678901234") }
      let(:account_params) { attributes_for(:account, account_number: "", verifier_digit: "") }
      let(:invalid_params) { { supplier: supplier_params, account: account_params } }

      it "return an error no process" do
        post url, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to include("can't be blank")
      end
    end

    context "with invalids cnpj" do
      let(:supplier_params) { attributes_for(:supplier, name: "Error cnpj", cnpj: "12345678901234") }
      let(:account_params) { attributes_for(:account, account_number: "account error", verifier_digit: "32") }
      let(:invalid_params) { { supplier: supplier_params, account: account_params } }

      it "return an error no process" do
        post url, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to include("is invalid")
      end
    end

  end

  describe "GET #index" do
    supplier1 = FactoryBot.create(:supplier, name: Faker::Company.name, cnpj: CNPJ.generate)
    supplier2 = FactoryBot.create(:supplier, name: Faker::Company.name, cnpj: CNPJ.generate)
    supplier3 = FactoryBot.create(:supplier, name: Faker::Company.name, cnpj: CNPJ.generate)

    context "when name parameter is provided" do
      it "returns a JSON response with the filtered list of suppliers" do

        get url, params: { name: supplier2.name }

        expect(response).to be_successful
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq([
                                                  {
                                                    "id" => supplier2.id,
                                                    "name" => supplier2.name,
                                                    "cnpj" => supplier2.cnpj,
                                                    "created_at" => supplier2.created_at.as_json,
                                                    "updated_at" => supplier2.updated_at.as_json
                                                  }
                                                ])
      end
    end
  end
end
