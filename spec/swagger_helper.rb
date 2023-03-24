require 'rails_helper'
require_relative './support/suppliers_swagger_helper.rb'

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
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'Servidor de desenvolvimento'
        }
      ]
    }
  }
  config.swagger_format = :yaml

  # Inclui as definições do arquivo suppliers_swagger_helper.rb
  # config.instance_eval(&SuppliersSwaggerHelper::ROUTES)
end
