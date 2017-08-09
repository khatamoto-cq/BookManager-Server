Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'login' => 'user_token#create'
      resources :books, except: :destroy
    end
  end
end
