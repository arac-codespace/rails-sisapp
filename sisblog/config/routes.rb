Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { registrations: "registrations"}
  root to: 'pages#home'
  get 'sobre_nosotras', to: 'pages#about'
  get 'resenas', to: 'pages#resenas'
  
  #Only an authenticated user can get access to these actions
  authenticate :user do
    resources :dramas, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :dramas, only: [:index, :show]

  #Only an authenticated user can get access to these actions 
  authenticate :user do
    resources :movies, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :movies, only: [:index, :show]
  
  authenticate :user do
    resources :animes, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :animes, only: [:index, :show]
  
  authenticate :user do
    resources :books, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :books, only: [:index, :show]
  
  authenticate :user do
    resources :makeups, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :makeups, only: [:index, :show]  
  
  

end