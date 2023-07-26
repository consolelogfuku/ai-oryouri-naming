Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'dishes#new'

  resources :dishes, param: :uuid do
    get 'result', on: :member
  end
end
