class BooksController < ApplicationController
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
  def create
    book = Book.new(book_params)

    if book.valid? && book.save
      render json: book, status: :created
    else
      render json: { errors: book.errors.messages }, status: :unprocessable_entity
    end
  end

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
