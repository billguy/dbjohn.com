DbjohnCom::Application.routes.draw do

  # redirect old wordpress blogs
  get '/:year/:month/:day/:id' => redirect { |params, req| "blogs/#{URI.escape(params[:id])}" }, :constraints => { :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/, :id => /.*/ }

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

  get 'search', to: 'home#search'

  resources :pages
  get ':id', to: 'pages#show'
  root to: 'home#index'

end
