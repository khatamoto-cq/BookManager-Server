Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'login' => 'user_token#create'
      post 'sign_up' => 'users#create'
      resources :books, except: [:show, :destroy]
    end
  end
end
