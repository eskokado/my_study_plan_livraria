class BooksController < ApplicationController
  def create
    book = Book.new(book_params)

    if book.valid? && book.save
      render json: book, status: :created
    else
      render json: { errors: book.errors.messages }, status: :unprocessable_entity
    end
  end


  def book_params
    return {} unless params.has_key?(:book)
    params.require(:book).permit(:id, :published_at, :isbn, :author_id, :title)
  end
end
