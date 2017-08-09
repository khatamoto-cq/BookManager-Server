Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'user_token' => 'user_token#create'
      post 'sign_up' => 'user_token#create'
      resources :books, except: :destroy
    end
  end
end
