RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API de Livros',
        version: 'v1',
        description: 'API para gerenciamento de livros'
      },
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'Servidor de desenvolvimento'
        }
      ],
      paths: {
        '/suppliers/{id}': {
          get: {
            tags: ['Fornecedores'],
            summary: 'Exibe informações de um fornecedor',
            description: 'Retorna informações de um fornecedor, incluindo seus autores e livros relacionados',
            operationId: 'getSupplierById',
            parameters: [
              {
                name: 'id',
                in: 'path',
                description: 'ID do fornecedor a ser retornado',
                required: true,
                schema: {
                  type: :integer,
                  format: :int64
                }
              }
            ],
            responses: {
              '200': {
                description: 'Informações do fornecedor, autores e livros relacionados',
                content: {
                  'application/json': {
                    schema: {
                      '$ref' => '#/components/schemas/SupplierWithDetails'
                    }
                  }
                }
              },
              '404': {
                description: 'Fornecedor não encontrado',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        message: { type: :string }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      #          .merge(SuppliersSwaggerHelper.paths),
      # components: {
      #   schemas: {
      #     # Definições de esquemas aqui
      #   }
      # }
    }
  }
end
