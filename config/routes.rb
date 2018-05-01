Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :foods, except: [:new, :edit]
      resources :meals, only: [:index]
      namespace :meals, path: 'meals/:meal_id' do
        resources :foods, only: [:index]
      end
    end
  end
end
