Rails.application.routes.draw do
  resources :players, only: [:show]

  resources :scores, only: [:create, :show, :destroy, :index]
end
