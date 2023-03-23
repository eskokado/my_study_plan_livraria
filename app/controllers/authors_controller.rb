class AuthorsController < ApplicationController
  def create
    author = Author.new(author_params)

    if author.valid? && author.save
      render json: author, status: :created
    else
      render json: { errors: author.errors.messages }, status: :unprocessable_entity
    end
  end

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
