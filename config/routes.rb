Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: 'users', sessions: 'login', confirmations: 'confirmation' }
    
    
    get  '/home', to: 'home#index'
    
    get  '/teamhome', to: 'team_home#index'
    post '/teamhome/create', to: 'team_home#create'
    post '/teamhome/join', to: 'team_home#join'
    post '/teamhome/newtoken', to: 'team_home#new_token'
    
    get  '/login', to: 'login#index'
    
    get  '/challenges', to: 'challenges#index'
    post '/challenges/create', to: 'challenges#create'
    
    post '/users/ban', to: 'team_home#ban'
    post '/teamhome/notification', to: 'team_home#notifications'
    get  '/profile', to: 'profile#index'
    get  '/settings', to: 'settings#index'
    
    root :to => redirect('/home')
    
end
