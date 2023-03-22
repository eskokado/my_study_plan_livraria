class PartsController < ApplicationController
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
