Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  get 'fajna_strona', to: 'home#index'
  get 'about', to: 'home#about'
  get 'terms', to: 'home#terms'
  resources :ads

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
