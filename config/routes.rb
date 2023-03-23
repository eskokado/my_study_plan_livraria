Rails.application.routes.draw do
  get "home" => "home#index"
  get 'authors/:id/with_books', to: 'authors#get_author_with_books', as: 'author_with_books'

  resources :authors
  resources :books
  resources :suppliers
  resources :parts
  resources :assemblies

end
