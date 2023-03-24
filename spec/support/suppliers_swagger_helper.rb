require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

# include RSpecApiDocumentation
RSpec.shared_context "suppliers", :shared_context => :metadata do
  module SuppliersSwaggerHelper
    # include RSpecApiDocumentation::DSL
    ROUTES = proc do
      path '/suppliers' do
        get 'Listar fornecedores' do
          tags 'Fornecedores'
          produces 'application/json'
          parameter name: :name, in: :query, type: :string, description: 'Nome do fornecedor'
          parameter name: :author_name, in: :query, type: :string, description: 'Nome do autor'
          parameter name: :account_number, in: :query, type: :string, description: 'Número da conta bancária'

          response '200', 'Lista de fornecedores' do
            schema type: :array,
                   items: {
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       cnpj: { type: :string }
                     }
                   }

            run_test!
          end

          response '422', 'Entidade não processável' do
            let(:name) { '' }
            let(:author_name) { '' }
            let(:account_number) { '' }

            schema type: :object,
                   properties: {
                     errors: {
                       type: :object,
                       properties: {
                         name: { type: :array, items: { type: :string } },
                         cnpj: { type: :array, items: { type: :string } }
                       }
                     }
                   }

            run_test!
          end

          response '404', 'Não encontrado' do
            let(:name) { 'INVALID' }
            let(:author_name) { 'INVALID' }
            let(:account_number) { 'INVALID' }

            schema type: :object,
                   properties: {
                     message: { type: :string }
                   }

            run_test!
          end
        end
      end
    end
  end

  RSpec.configure do |config|
    # Inclui as definições do arquivo suppliers_swagger_helper.rb
    config.instance_eval(&SuppliersSwaggerHelper::ROUTES)
  end
end
