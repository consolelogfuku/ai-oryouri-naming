Rails.application.routes.draw do

  root to: 'dishes#new'
  get 'sign_up', to: 'users#new'
  post 'sign_up', to: 'users#create'

  resources :users, param: :uuid, only: [:create, :show] 
  resources :dishes, param: :uuid do
    get 'result', on: :member
  end
end
