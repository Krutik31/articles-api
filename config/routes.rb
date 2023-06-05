Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :articles, except: %i[new edit] do
        get '/page/:page', action: :index, on: :collection
        resources :comments, except: %i[index new edit] do
          collection do
            get 'search', to: 'comments#search'
          end
        end
        collection do
          resources :comments, only: %i[index]
          get 'search', to: 'articles#search'
        end
      end
    end
  end
end
