Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: 'users', sessions: 'login', confirmations: 'confirmation' }
    
    
    
    get  '/team/home', to: 'team_home#index'
    post '/team/create', to: 'team_home#create'
    post '/team/join', to: 'team_home#join'
    post '/team/newtoken', to: 'team_home#new_token'
    get  '/team/stat', to: 'team_stat#index'
    post '/team/notification', to: 'team_home#notifications'
    put  '/team/edit', to: 'team_home#update'
    get  '/team/edit', to: 'settings#index'
    
    get  '/login', to: 'login#index'
    
    get  '/home', to: 'home#index'
    
    get  '/challenges', to: 'challenges#index'
    post '/challenges/create', to: 'challenges#create'
    
    get  '/users/stat', to: 'user_stat#index'
    post '/users/ban', to: 'team_home#ban'
    get  '/users/profile', to: 'profile#index'
    get  '/users/settings', to: 'settings#index'

    put  '/profile/edit', to: 'profile#update'
    
    post '/ctfs/maps', to: 'team_home#maps'
    
    get  '/flag', to: 'home#flag'
    
    root :to => redirect('/home')
    
end
