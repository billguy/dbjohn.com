DbjohnCom::Application.routes.draw do

  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  mount Ckeditor::Engine => '/ckeditor'
  resources :pics do
    member do
      get "approve(/:token)", :to => "pics#approve", :as => :approve
    end
  end

  resources :tags, only: [:index]
  get ':id', to: 'pages#show', as: :page
  resources :pages, except: [:index]
  root to: 'home#index'

end
