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
  # redirect old wordpress blogs
  get '/:year/:month/:day/:id' => redirect { |params, req| "/blogs/#{URI.parse(URI.encode(params[:id].strip))}" }

  get 'search', to: 'home#search'

  resources :pages
  get ':id', to: 'pages#show'
  root to: 'home#index'

end
