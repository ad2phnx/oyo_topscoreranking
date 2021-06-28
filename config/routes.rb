Rails.application.routes.draw do
  get 'health/index'
  resources :players, only: [:index, :show]
  resources :scores, only: [:index, :create, :show, :destroy]
end
