class BooksController < ApplicationController

  # POST /api/v1/books
  def create
    @book = Book.new
    @book.attributes = book_params
    @book.save!
    render :show
  rescue
    render json: { errors: { fields: @book.errors.messages } }, status: :unprocessable_entity
  end

  def book_params
    return {} unless params.has_key?(:book)
    params.require(:book).permit(:id, :published_at, :author_id)
  end
end
