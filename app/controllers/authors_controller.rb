class AuthorsController < ApplicationController
  def create
    author = Author.new(author_params)

    if author.save
      render json: author, status: :created
    else
      render json: { errors: author.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def author_params
    params.require(:author).permit(:name, :cpf)
  end
end
