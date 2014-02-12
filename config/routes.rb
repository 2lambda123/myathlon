Myathlon::Application.routes.draw do
  devise_for :users

  scope '/api' do
      resources :weights, only: :index, defaults: {format: :json}
  end
  root to: "users#show"
  
  get 'sms', to: 'sms#receive'

end
