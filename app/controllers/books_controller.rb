class BooksController < ApplicationController
  # Lista todos os livros ou os livros de um determinado autor ou com um determinado título.
  #
  # @param author_name [String] Nome do autor para filtrar os livros.
  # @param title [String] Título do livro para filtrar os livros.
  #
  # @example Requisição de exemplo:
  #   GET /books?author_name=J.K.%20Rowling
  #
  # @example Resposta de exemplo:
  #   [
  #     {
  #       "id": 3,
  #       "title": "Harry Potter and the Philosopher's Stone",
  #       "published_at": "1997-06-26",
  #       "isbn": "9780590353403",
  #       "created_at": "2023-03-24T18:00:00.000Z",
  #       "updated_at": "2023-03-24T18:00:00.000Z",
  #       "author_id": 2
  #     }
  #   ]
  #
  # @example Resposta de erro (status 404):
  #   not_found
  #
  def index
    if params[:author_name].present?
      @books = Book.joins(:author).where("authors.name ILIKE ?", "%#{params[:author_name]}%").order(published_at: :desc)
    else
      if params[:title].present?
        @books = Book.where('title ILIKE ?', "%#{params[:title]}%").order(published_at: :desc)
      else
        @books = Book.all.order(published_at: :desc)
      end
    end
    render json: @books
  end

  # Cria um novo livro.
  #
  # @param book [Hash] Parâmetros do livro a serem criados (published_at, isbn, author_id, title).
  #
  # @example Requisição de exemplo:
  #   POST /books
  #   {
  #     "book": {
  #       "published_at": "2023-03-24",
  #       "isbn": "9780590353404",
  #       "author_id": 3,
  #       "title": "The Lord of the Rings: The Fellowship of the Ring"
  #     }
  #   }
  #
  # @example Resposta de exemplo (status 201):
  #   {
  #     "id": 4,
  #     "published_at": "2023-03-24",
  #     "isbn": "9780590353404",
  #     "created_at": "2023-03-24T18:00:00.000Z",
  #     "updated_at": "2023-03-24T18:00:00.000Z",
  #     "author_id": 3,
  #     "title": "The Lord of the Rings: The Fellowship of the Ring"
  #   }
  #
  # @example Resposta de erro (status 422):
  #   {
  #     "errors": {
  #       "published_at": ["não pode ficar em branco"]
  #     }
  #   }
  #
  def create
    book = Book.new(book_params)

    if book.valid? && book.save
      render json: book, status: :created
    else
      render json: { errors: book.errors.messages }, status: :unprocessable_entity
    end
  end

  # Retorna um livro com sua montagem de peças e custos totais.
  #
  # @param id [Integer] ID do livro.
  #
  # @example Requisição de exemplo:
  #   GET /books/1/get_book_with_assembly_parts_and_costs
  #
  # @example Resposta de exemplo:
  #   {
  #     "book": {
  #       "id": 1,
  #       "title": "The Hobbit",
  #       "published_at": "1937-09-21",
  #       "isbn": "9780547928227",
  #       "created_at": "2023-03-24T18:00:00.000Z",
  #       "updated_at": "2023-03-24T18:00:00.000Z",
  #       "author_id": 1
  #     },
  #     "assembly": {
  #       "id": 1,
  #       "name": "Assembly 1",
  #       "created_at": "2023-03-24T18:00:00.000Z",
  #       "updated_at": "2023-03-24T18:00:00.000Z",
  #       "book_id": 1
  #     },
  #     "total_parts": 3,
  #     "total_cost": "45.0"
  #   }
  #
  # @example Resposta de erro (status 404):
  #   not_found
  #
  def get_book_with_assembly_parts_and_costs
    book_id = params[:id]
    @book = Book.find(book_id)
    @assembly = @book.assemblies.includes(:parts).first
    @total_parts = @assembly.parts.count
    @total_cost = @assembly.parts.sum(:value)

    render json: {
      book: @book,
      assembly: @assembly,
      total_parts: @total_parts,
      total_cost: @total_cost
    }
  end

  def book_params
    return {} unless params.has_key?(:book)
    params.require(:book).permit(:id, :published_at, :isbn, :author_id, :title)
  end
end
