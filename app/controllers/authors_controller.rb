class AuthorsController < ApplicationController
  # Cria um novo autor.
  #
  # @param author [Hash] Parâmetros do autor a serem criados (name, cpf).
  #
  # @example Requisição de exemplo:
  #   POST /authors
  #   {
  #     "author": {
  #       "name": "J.K. Rowling",
  #       "cpf": "123.456.789-10"
  #     }
  #   }
  #
  # @example Resposta de exemplo (status 201):
  #   {
  #     "id": 4,
  #     "name": "J.K. Rowling",
  #     "cpf": "123.456.789-10",
  #     "created_at": "2023-03-24T18:00:00.000Z",
  #     "updated_at": "2023-03-24T18:00:00.000Z"
  #   }
  #
  # @example Resposta de erro (status 422):
  #   {
  #     "errors": {
  #       "name": ["não pode ficar em branco"]
  #     }
  #   }
  #
  def create
    author = Author.new(author_params)

    if author.valid? && author.save
      render json: author, status: :created
    else
      render json: { errors: author.errors.messages }, status: :unprocessable_entity
    end
  end

  # Retorna um autor com seus livros publicados.
  #
  # @param id [Integer] ID do autor.
  #
  # @example Requisição de exemplo:
  #   GET /authors/1/get_author_with_books
  #
  # @example Resposta de exemplo:
  #   {
  #     "author": {
  #       "id": 1,
  #       "name": "J.R.R. Tolkien",
  #       "cpf": "123.456.789-10",
  #       "created_at": "2023-03-24T18:00:00.000Z",
  #       "updated_at": "2023-03-24T18:00:00.000Z"
  #     },
  #     "books": [
  #       {
  #         "id": 1,
  #         "title": "The Hobbit",
  #         "published_at": "1937-09-21",
  #         "isbn": "9780547928227",
  #         "created_at": "2023-03-24T18:00:00.000Z",
  #         "updated_at": "2023-03-24T18:00:00.000Z",
  #         "author_id": 1
  #       },
  #       {
  #         "id": 2,
  #         "title": "The Lord of the Rings",
  #         "published_at": "1954-07-29",
  #         "isbn": "9780618640157",
  #         "created_at": "2023-03-24T18:00:00.000Z",
  #         "updated_at": "2023-03-24T18:00:00.000Z",
  #         "author_id": 1
  #       }
  #     ],
  #     "total_books_published": 2
  #   }
  #
  # @example Resposta de erro (status 404):
  #   not_found
  #
  def get_author_with_books
    @author = Author.includes(:books).find(params[:id])
    @total_books_published = @author.books.count

    render json: { author: @author, books: @author.books, total_books_published: @total_books_published }
  end

  private

  def author_params
    params.require(:author).permit(:name, :cpf)
  end
end
