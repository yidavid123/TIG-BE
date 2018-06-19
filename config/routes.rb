Rails.application.routes.draw do

  resources :users
  resources :gtg_rules
  resources :gtgs
  resources :outings, defaults: {format: :json}
  resources :friends, defaults: {format: :json}
  resources :groups, defaults: {format: :json}
  resources :users, defaults: {format: :json}

  post 'login_token' => 'user_token#login'
  post 'get_next_course' => 'yelp#get_next_course'

end
