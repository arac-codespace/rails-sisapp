Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  
  devise_for :users, :skip => [:sessions]

  as :user do
      get "/admin" => "devise/sessions#new", :as => :new_user_session
      post "/admin" => "devise/sessions#create", :as => :user_session
      delete "/logout" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  
  root to: 'pages#home'
  get 'sobre_nosotras', to: 'pages#about'
  get 'resenas', to: 'pages#resenas'
  get 'cuidado_personal', to: 'pages#cuidado_personal'
  get 'recomendaciones', to: 'pages#recomendaciones'
  # get 'projects', to: 'pages#projects'
  

  authenticate :user, lambda {|u| u.admin?} do
    resources :projects, only: [:new, :create, :edit, :update, :destroy] do
      resources :chapters, only: [:new, :create, :edit, :update, :destroy]
    end
  end  
  
  resources :projects, only: [:index, :show] do 
    resources :chapters, only: [:show]
  end  
  
  
  #Only an authenticated user can get access to these actions
  authenticate :user, lambda {|u| u.admin?} do
    resources :dramas, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :dramas, only: [:index, :show]

  #Only an authenticated user can get access to these actions 
  authenticate :user, lambda {|u| u.admin?} do
    resources :movies, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :movies, only: [:index, :show]
  
  authenticate :user, lambda {|u| u.admin?} do
    resources :animes, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :animes, only: [:index, :show]
  
  authenticate :user, lambda {|u| u.admin?} do
    resources :books, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :books, only: [:index, :show]
  
  authenticate :user, lambda {|u| u.admin?} do
    resources :makeups, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :makeups, only: [:index, :show]  
  
  authenticate :user, lambda {|u| u.admin?} do
    resources :facial_products, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :facial_products, only: [:index, :show]    
  
  
  authenticate :user, lambda {|u| u.admin?} do
    resources :others, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :others, only: [:index, :show]   
  
  
  authenticate :user, lambda {|u| u.admin?} do
    resources :crafts, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :crafts, only: [:index, :show] 
  
  authenticate :user, lambda {|u| u.admin?} do
  resources :cares, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :cares, only: [:index, :show]   
  
  authenticate :user, lambda {|u| u.admin?} do
  resources :recommendations, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :recommendations, only: [:index, :show]   
  
  
  

end