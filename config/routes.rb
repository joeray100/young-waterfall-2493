Rails.application.routes.draw do
  resources :studios, only: [:show]
  resources :movies, only: [:show]
  resources :actors, only: [:show]
end
