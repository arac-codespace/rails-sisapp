Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { registrations: "registrations"}
  root to: 'pages#home'
  get 'sobre_nosotras', to: 'pages#about'
  get 'resenas', to: 'pages#resenas'
  get 'cuidado_personal', to: 'pages#cuidado_personal'
  
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
  
  authenticate :user do
    resources :facial_products, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :facial_products, only: [:index, :show]    
  
  
  authenticate :user do
    resources :others, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :others, only: [:index, :show]   
  
  
  authenticate :user do
    resources :crafts, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :crafts, only: [:index, :show] 
  
  authenticate :user do
  resources :cares, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :cares, only: [:index, :show]   
  
  
  

end