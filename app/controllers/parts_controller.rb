class PartsController < ApplicationController
  # Cria uma nova parte associada a um fornecedor e a um livro.
  #
  # @param supplier_id [Integer] ID do fornecedor ao qual a parte pertence.
  # @param book_id [Integer] ID do livro ao qual a parte pertence.
  # @param part [Hash] Parâmetros da parte a serem criados (part_number, name, book_id, supplier_id).
  #
  # @example Requisição de exemplo:
  #   POST /suppliers/1/books/1/parts
  #   {
  #     "part": {
  #       "part_number": "12345",
  #       "name": "Display",
  #       "book_id": 1,
  #       "supplier_id": 1
  #     }
  #   }
  #
  # @example Resposta de exemplo (status 201):
  #   {
  #     "part": {
  #       "id": 1,
  #       "part_number": "12345",
  #       "name": "Display",
  #       "book_id": 1,
  #       "supplier_id": 1,
  #       "created_at": "2023-03-24T15:00:00.000Z",
  #       "updated_at": "2023-03-24T15:00:00.000Z"
  #     }
  #   }
  #
  # @example Resposta de erro (status 422):
  #   {
  #     "errors": {
  #       "part_number": ["não pode ficar em branco"],
  #       "name": ["não pode ficar em branco"]
  #     }
  #   }
  #
  def create
    supplier = Supplier.find(params[:supplier_id])
    book = Book.find(params[:book_id])
    part = supplier.parts.build(part_params)
    part.book = book
    if part.save
      render json: { part: part }, status: :created
    else
      render json: { errors: part.errors }, status: :unprocessable_entity
    end
  end

  private

  def part_params
    params.require(:part).permit(:part_number, :name, :book_id, :supplier_id)
  end
end
