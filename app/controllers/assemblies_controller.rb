class AssembliesController < ApplicationController
  # Retorna todas as montagens ou somente aquelas que contêm uma peça específica.
  #
  # @param part_name [String] Nome da peça a ser filtrada.
  #
  # @example Requisição de exemplo:
  #   GET /assemblies?part_name=Parafuso
  #
  # @example Resposta de exemplo:
  #   [
  #     {
  #       "id": 1,
  #       "name": "Montagem A",
  #       "book_id": 1,
  #       "created_at": "2023-03-24T18:00:00.000Z",
  #       "updated_at": "2023-03-24T18:00:00.000Z"
  #     },
  #     {
  #       "id": 2,
  #       "name": "Montagem B",
  #       "book_id": 1,
  #       "created_at": "2023-03-24T18:00:00.000Z",
  #       "updated_at": "2023-03-24T18:00:00.000Z"
  #     }
  #   ]
  #
  # @example Resposta de erro (status 404):
  #   not_found
  #
  def index
    if params[:part_name].present?
      @assemblies = Assembly.with_part_name(params[:part_name])
    else
      @assemblies = Assembly.all
    end
    render json: @assemblies
  end

  # Cria uma nova montagem com as peças especificadas.
  #
  # @param assembly [Hash] Parâmetros da montagem a serem criados (name, book_id, part_ids).
  #
  # @example Requisição de exemplo:
  #   POST /assemblies
  #   {
  #     "assembly": {
  #       "name": "Montagem C",
  #       "book_id": 1,
  #       "part_ids": [1, 2, 3]
  #     }
  #   }
  #
  # @example Resposta de exemplo (status 201):
  #   {
  #     "id": 3,
  #     "name": "Montagem C",
  #     "book_id": 1,
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
