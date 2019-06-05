Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  concern :eventable do
    resources :events, shallow: true
  end

  namespace :api do
    namespace :v1 do
      resources :centers, concerns: :eventable
      resources :events, only: :index
      resources :users do
        resources :events, only: :index
        resources :centers, only: %i[index]
      end
      post 'login' => 'user_token#create'
      get '/apidocs' => redirect('/swagger-ui/dist/index.html?url=http://localhost:3001/api/v1/docs')
      resources :docs, only: [:index]
    end
  end

  get '*path', to: "application#fallback_index_html", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end
end
