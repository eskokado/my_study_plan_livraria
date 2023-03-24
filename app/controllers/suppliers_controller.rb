require 'cpf_cnpj'
class SuppliersController < ApplicationController
  # GET /suppliers
  # Exemplo de requisição: GET /suppliers?name=Apple
  # Exemplo de resposta:
  # [
  #   {
  #     "id": 1,
  #     "name": "Apple Inc.",
  #     "cnpj": "12.345.678/0001-90",
  #     "created_at": "2023-03-24T10:00:00.000Z",
  #     "updated_at": "2023-03-24T10:00:00.000Z"
  #   },
  #   {
  #     "id": 2,
  #     "name": "Apple Store",
  #     "cnpj": "23.456.789/0001-01",
  #     "created_at": "2023-03-24T11:00:00.000Z",
  #     "updated_at": "2023-03-24T11:00:00.000Z"
  #   }
  # ]
  # Exemplo de requisição: GET /suppliers?account_number=1234
  # Exemplo de resposta:
  # [
  #   {
  #     "id": 3,
  #     "name": "Microsoft Corporation",
  #     "cnpj": "34.567.890/0001-12",
  #     "created_at": "2023-03-24T12:00:00.000Z",
  #     "updated_at": "2023-03-24T12:00:00.000Z"
  #   }
  # ]
  # Exemplo de requisição: GET /suppliers?author_name=John%20Doe
  # Exemplo de resposta:
  # [
  #   {
  #     "id": 4,
  #     "name": "Google Inc.",
  #     "cnpj": "45.678.901/0001-23",
  #     "created_at": "2023-03-24T13:00:00.000Z",
  #     "updated_at": "2023-03-24T13:00:00.000Z"
  #   }
  # ]
  def index
    if params[:author_name]
      @suppliers = Supplier.joins(parts: { book: :author }).where(authors: { name: params[:author_name] }).select("*").distinct
    else
      if params[:account_number].present?
        @suppliers = Supplier.joins(:account).where(accounts: { account_number: params[:account_number] })
      else
        name = params[:name].present? ? params[:name] : ""
        @suppliers = Supplier.where("name LIKE ?", "%#{name}%")
      end
    end

    render json: @suppliers
  end

  # POST /suppliers
  # Exemplo de requisição:
  # {
  #   "supplier": {
  #     "name": "Amazon Inc.",
  #     "cnpj": "56.789.012/0001-34"
  #   },
  #   "account": {
  #     "account_number": "12345",
  #     "verifier_digit": "6"
  #   }
  # }
  # Exemplo de resposta (status 201):
  # {
  #   "supplier": {
  #     "id": 5,
  #     "name": "Amazon Inc.",
  #     "cnpj": "56.789.012/0001-34",
  #     "created_at": "2023-03-24T14:00:00.000Z",
  #     "updated_at": "2023-03-24T14:00:00.000Z"
  #   },
  #   "account": {
  #     "id": 2,
  #     "account_number": "12345",
  #     "verifier_digit": "6",
  #     "supplier_id": 5,
  #     "created_at": "2023-03-24T14:00:00.000Z",
  #     "updated_at": "2023-03-24T14:00:00.000Z"
  #   }
  # }
  # Exemplo de resposta (status 422):
  # {
  #   "errors": {
  #     "name": ["não pode ficar em branco"],
  #     "cnpj": ["não pode ficar em branco"],
  #     "account_number": ["não pode ficar em branco"],
  #     "verifier_digit": ["não pode ficar em branco"]
  #   }
  # }
  def create
    @supplier = Supplier.new(supplier_params)
    @account = @supplier.build_account(account_params)

    if @supplier.valid? && @account.valid? && @supplier.save && @account.save
      render json: { supplier: @supplier, account: @account }, status: :created
    else
      render json: { errors: @supplier.errors.messages.merge(@account.errors.messages) }, status: :unprocessable_entity
    end
  end

  # GET /suppliers/:id
  #
  # Exibe informações detalhadas de um fornecedor, incluindo os autores e livros associados.
  #
  # @param id [Integer] ID do fornecedor a ser exibido.
  #
  # @example Requisição de exemplo:
  #   GET /suppliers/1
  #
  # @example Resposta de exemplo:
  #   {
  #     "id": 1,
  #     "name": "Apple Inc.",
  #     "cnpj": "12.345.678/0001-90",
  #     "created_at": "2023-03-24T10:00:00.000Z",
  #     "updated_at": "2023-03-24T10:00:00.000Z",
  #     "parts": [
  #       {
  #         "id": 1,
  #         "quantity": 5,
  #         "book_id": 1,
  #         "created_at": "2023-03-24T10:00:00.000Z",
  #         "updated_at": "2023-03-24T10:00:00.000Z",
  #         "book": {
  #           "id": 1,
  #           "title": "The Apple Revolution",
  #           "published_at": "2017-06-01",
  #           "created_at": "2023-03-24T10:00:00.000Z",
  #           "updated_at": "2023-03-24T10:00:00.000Z",
  #           "author_id": 1,
  #           "author": {
  #             "id": 1,
  #             "name": "Steve Jobs",
  #             "created_at": "2023-03-24T10:00:00.000Z",
  #             "updated_at": "2023-03-24T10:00:00.000Z"
  #           }
  #         }
  #       }
  #     ]
  #   }
  #
  # @example Resposta de erro (status 404):
  #   not_found
  #
  def show
    begin
      @supplier = Supplier.supplier_with_authors_and_books(params[:id])
      render json: @supplier.to_json(include: { parts: { include: { book: { include: :author } } } })
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  private

  def supplier_params
    params.require(:supplier).permit(:name, :cnpj)
  end

  def account_params
    params.require(:account).permit(:account_number, :verifier_digit)
  end
end
