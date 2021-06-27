Rails.application.routes.draw do
  get 'health/index'
  resources :players, only: [:show]
  resources :scores, only: [:index, :create, :show, :destroy]
end
