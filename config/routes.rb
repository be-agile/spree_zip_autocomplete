Spree::Core::Engine.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v2 do
      resources :zip_autocomplete, only: [] do
        collection do
          get :search
        end
      end
    end
  end
end
