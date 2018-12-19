Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'centers/create'
  get 'centers', to: 'centers#index'

  namespace :api do
    namespace :v1 do
      resources :centers
    end
  end
end
