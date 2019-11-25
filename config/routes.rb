Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions'}

  resources :users
    # , defaults: { format: 'json' }
  # resources :lessons
  # resources :majors
  resources :admins
  resources :students
  resources :profs
  resources :fields
  resources :reshtehs
end
