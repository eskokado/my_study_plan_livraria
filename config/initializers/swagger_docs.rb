Swagger::Docs::Config.base_api_controller = ActionController::API
Swagger::Docs::Config.register_apis({
                                      "1.0" => {
                                        # o caminho onde a documentação será exibida
                                        api_extension_type: :json,
                                        api_file_path: "public/",
                                        base_path: "http://localhost:3000",
                                        # o nome do arquivo de saída
                                        clean_directory: true,
                                        formatting: :pretty,
                                        hide_documentation_path: true,
                                        hide_format: true,
                                        info: {
                                          title: "API Documentation de livraria",
                                          description: "API para gerenciar os livros de uma livraria",
                                          contact: "Edson Shideki Kokado",
                                          license: "MIT License",
                                          license_url: "https://opensource.org/licenses/MIT",
                                          terms_of_service_url: "https://opensource.org/licenses/MIT",
                                          version: "1.0"
                                        }
                                      }
                                    })
