Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { registrations: "registrations"}
  root to: 'pages#home'
  get 'sobre_nosotras', to: 'pages#about'
  authenticate :user do
    resources :dramas, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :dramas, only: [:index, :show]
  get 'resenas', to: 'pages#resenas'
end
