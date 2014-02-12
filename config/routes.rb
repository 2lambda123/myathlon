Myathlon::Application.routes.draw do
  devise_for :users

  root to: "users#show"
  
  get 'sms', to: 'sms#receive'

  resources :weights, only: :index
end
