Rails.application.routes.draw do
  root "repositories#new"

  resources :repositories
end
