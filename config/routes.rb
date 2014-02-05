DbjohnCom::Application.routes.draw do

  devise_for :users

  mount Ckeditor::Engine => '/ckeditor'
  resources :pics do
    member do
      get "approve(/:token)", :to => "pics#approve", :as => :approve
    end
  end

  resources :slogans, except: [:show]
  resources :tags, only: [:index]
  resources :blogs
  resources :contacts, only: [:new, :create], path: 'contact'

  resources :pages
  get ':id', to: 'pages#show'
  root to: 'home#index'

end
