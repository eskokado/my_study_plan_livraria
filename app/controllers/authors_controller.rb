class AuthorsController < ApplicationController
  def create
    @author = Author.new
    @author.attributes = author_params
    @author.save!
    render :show
  rescue
    render json: { errors: { fields: @author.errors.messages } }, status: :unprocessable_entity
  end

  def author_params
    return {} unless params.has_key?(:author)
    params.require(:author).permit(:id, :name)
  end
end
