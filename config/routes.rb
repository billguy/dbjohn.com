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

  get ':id', to: 'pages#show', as: :page
  resources :pages, except: [:index]
  root to: 'home#index'

end
