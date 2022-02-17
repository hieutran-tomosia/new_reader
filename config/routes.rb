Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "bests#index"

  resources :bests, only: :index do
    collection do
      get :get_content
    end
  end
end
