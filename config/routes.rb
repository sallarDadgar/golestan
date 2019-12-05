Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions'}

  get "(*path)", to: "application#app"
  resources :users
    # , defaults: { format: 'json' }
  # resources :lessons
  # resources :majors
  resources :admins
  resources :students
  resources :profs
  resources :fields
  resources :reshtehs
  resources :stusons
  resources :projors

end
