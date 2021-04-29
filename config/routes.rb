Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #signup routes jsut to make the url pretty

  root 'sessions#new'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  get '/users/:id/settings' => 'users#settings'
  post '/users/:id/settings' => 'users#update_settings'

  get '/logout' => 'sessions#destroy'

  #add and remove associations of user to station
  get '/users/:user_id/stations/:id/delete' => 'stations#delete_user' 
  get '/users/:user_id/stations/:id' => 'stations#add_user'

  get '/notes/:id/delete' => 'notes#destroy'

  #display stations that belong to user
  get '/users/:id/stations' => 'users#users_stations'

  resources :users
  resources :stations
  resources :notes
end
