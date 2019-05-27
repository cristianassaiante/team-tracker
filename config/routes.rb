Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: 'home'}
    
    get '/home', to: 'home#index'
    get '/login', to: 'login#index'
    
    root :to => redirect('/home')
end
