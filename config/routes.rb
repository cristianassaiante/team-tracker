Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: 'home', sessions: 'login', confirmations: 'confirmation' }
    
    get '/home', to: 'home#index'
    get '/teamhome', to: 'team_home#index'
    post '/teamhome', to: 'team_home#create'
    get '/login', to: 'login#index'
    
    root :to => redirect('/home')
    
end
