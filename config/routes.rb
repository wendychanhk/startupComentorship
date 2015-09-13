Rails.application.routes.draw do


   # match' /users/signup', to: 'users#new',  via: 'get'
 #   match' /users', to: 'users#create',  via: 'post'


  #  match '/users/edit', to: 'users#edit',  via: 'get'

 #   match "/users/update", :to => "users#update", :via => [:put, :patch]



  devise_for :users

  authenticated :user do
    root 'users#index'
  end

  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end

  resources :conversations do
    resources :messages
  end


get '/users/profile', to: 'users#profile'



end




 

