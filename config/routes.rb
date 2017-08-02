Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books, except: :destroy
    end
  end
end
