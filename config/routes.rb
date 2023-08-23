Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      post '/login', to: 'auth#login'
      post '/registration', to: 'auth#registration'
      resources :blogs, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
