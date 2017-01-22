Rails.application.routes.draw do
  root to: 'pages#home'
  get 'sobre_nosotras', to: 'pages#about'
  resources :dramas
end
