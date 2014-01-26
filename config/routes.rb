DbjohnCom::Application.routes.draw do

  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'
  root to: 'home#index'
end
