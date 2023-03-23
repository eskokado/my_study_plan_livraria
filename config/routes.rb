Rails.application.routes.draw do
  get "home" => "home#index"
  get 'authors/:id/with_books', to: 'authors#get_author_with_books', as: 'author_with_books'
  get 'books/:id/assembly_parts_and_costs', to: 'books#get_book_with_assembly_parts_and_costs', as: 'book_with_assembly_parts_and_costs'

  resources :authors
  resources :books
  resources :suppliers
  resources :parts
  resources :assemblies
end
