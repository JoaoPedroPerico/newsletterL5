Rails.application.routes.draw do
  resources :emails, only: [:new, :index, :create, :show]
  resources :templates, only: [:new, :create]
  root "emails#index"
end
