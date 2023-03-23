require 'rails_helper'

RSpec.describe SuppliersController, type: :controller do
  describe "GET #index" do
    context "when author name parameter is provided" do
      let!(:supplier) { FactoryBot.create(:supplier) }
      let!(:author) { FactoryBot.create(:author) }
      let!(:book) { FactoryBot.create(:book_with_parts, author: author) }
      let!(:part) { FactoryBot.create(:part_with_book, supplier: supplier, book: book) }

      it "returns a JSON response with the filtered list of suppliers" do
        get :index, params: { author_name: author.name }
        expect(response).to have_http_status(:success)
        expect(assigns(:suppliers)).to include(supplier)
      end
    end
  end

  describe 'GET #show' do
    let!(:supplier) { FactoryBot.create(:supplier) }
    let!(:author) { FactoryBot.create(:author) }
    let!(:book) { FactoryBot.create(:book, author: author) }
    let!(:part) { FactoryBot.create(:part, supplier: supplier, book: book) }

    it 'returns a JSON response with the supplier information along with related authors and books' do
      get :show, params: { id: supplier.id }

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(supplier.id)
      expect(json_response['parts'].first['book']['id']).to eq(book.id)
      expect(json_response['parts'].first['book']['author']['id']).to eq(author.id)
    end
  end
end

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

    context "when name parameter is provided" do
      it "returns a JSON response with the filtered list of suppliers" do
        supplier1 = FactoryBot.create(:supplier, name: Faker::Company.name, cnpj: Faker::Company.unique.brazilian_company_number(formatted: false))
        supplier2 = FactoryBot.create(:supplier, name: Faker::Company.name, cnpj: Faker::Company.unique.brazilian_company_number(formatted: false))
        supplier3 = FactoryBot.create(:supplier, name: Faker::Company.name, cnpj: Faker::Company.unique.brazilian_company_number(formatted: false))

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

    context "when name parameter is not provided" do
      let!(:supplier1) { FactoryBot.create(:supplier, name: Faker::Company.name, cnpj: Faker::Company.unique.brazilian_company_number(formatted: false)) }
      let!(:supplier2) { FactoryBot.create(:supplier, name: Faker::Company.name, cnpj: Faker::Company.unique.brazilian_company_number(formatted: false)) }
      let!(:supplier3) { FactoryBot.create(:supplier, name: Faker::Company.name, cnpj: Faker::Company.unique.brazilian_company_number(formatted: false)) }

      it "returns a JSON response with the unfiltered list of suppliers" do
        get url

        # Expect a successful response with a JSON body containing the unfiltered list of suppliers
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq([
                                                  {
                                                    "id" => supplier1.id,
                                                    "name" => supplier1.name,
                                                    "cnpj" => supplier1.cnpj,
                                                    "created_at" => supplier1.created_at.as_json,
                                                    "updated_at" => supplier1.updated_at.as_json
                                                  },
                                                  {
                                                    "id" => supplier2.id,
                                                    "name" => supplier2.name,
                                                    "cnpj" => supplier2.cnpj,
                                                    "created_at" => supplier2.created_at.as_json,
                                                    "updated_at" => supplier2.updated_at.as_json
                                                  },
                                                  {
                                                    "id" => supplier3.id,
                                                    "name" => supplier3.name,
                                                    "cnpj" => supplier3.cnpj,
                                                    "created_at" => supplier3.created_at.as_json,
                                                    "updated_at" => supplier3.updated_at.as_json
                                                  }
                                                ].as_json)
      end
    end

    context "when account_number parameter is provided" do
      let(:supplier1) { FactoryBot.create(:supplier) }
      let(:account1) { FactoryBot.create(:account, supplier: supplier1) }

      before { get url, params: { account_number: account1.account_number } }

      it "returns a JSON response with the filtered list of suppliers" do
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq([
                                                  {
                                                    "id" => supplier1.id,
                                                    "name" => supplier1.name,
                                                    "cnpj" => supplier1.cnpj,
                                                    "created_at" => supplier1.created_at.as_json,
                                                    "updated_at" => supplier1.updated_at.as_json
                                                  }
                                                ])
      end
    end
  end
end
