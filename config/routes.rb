Rails.application.routes.draw do
  get "home" => "home#index"
  resources :authors
  resources :books
  resources :suppliers
end
