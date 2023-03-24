module SuppliersControllerDocs
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_controller :suppliers, "Fornecedores"

    # Listagem de fornecedores
    swagger_api :index do
      summary "Lista de fornecedores"
      notes "Retorna uma lista de fornecedores"
      param :query, :name, :string, :optional, "Nome do fornecedor"
      param :query, :account_number, :string, :optional, "Número da conta do fornecedor"
      param :query, :author_name, :string, :optional, "Nome do autor"
      response :ok, "Success", :Supplier
      response :unprocessable_entity, "Unprocessable Entity", :ErrorModel
      response :not_found
    end

    # Criação de fornecedor
    swagger_api :create do
      summary "Criação de fornecedor"
      notes "Cria um novo fornecedor com uma conta associada"
      param :form, "supplier[name]", :string, :required, "Nome do fornecedor"
      param :form, "supplier[cnpj]", :string, :required, "CNPJ do fornecedor"
      param :form, "account[account_number]", :string, :required, "Número da conta do fornecedor"
      param :form, "account[verifier_digit]", :string, :required, "Dígito verificador da conta do fornecedor"
      response :created, "Created", :Supplier
      response :unprocessable_entity, "Unprocessable Entity", :ErrorModel
    end

    # Exibição de fornecedor com autores e livros associados
    swagger_api :show do
      summary "Exibição de fornecedor com autores e livros associados"
      notes "Retorna um fornecedor com seus autores e livros associados"
      param :path, :id, :integer, :required, "ID do fornecedor"
      response :ok, "Success", :SupplierWithAuthorsAndBooks
      response :not_found
    end
  end
end
