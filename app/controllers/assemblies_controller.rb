class AssembliesController < ApplicationController

  def index
    if params[:part_name].present?
      @assemblies = Assembly.joins(:part).where("parts.name ILIKE ?", "%#{params[:part_name]}%")
    else
      @assemblies = Assembly.all
    end
    render json: @assemblies
  end
  def create
    @assembly = Assembly.new(assembly_params)

    if @assembly.save
      render json: @assembly, status: :created
    else
      render json: { errors: @assembly.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def assembly_params
    params.require(:assembly).permit(:name, :book_id, part_ids: [])
  end
end
