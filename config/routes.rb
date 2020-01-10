Rails.application.routes.draw do
  root "repositories#new"

  resources :repositories
  resources :contributors
end
