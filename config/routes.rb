Rails.application.routes.draw do
  get 'braintree/new'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:create, :update, :edit, :show] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  #get 'welcome/index'

  #get 'users/show'

  resources :listings do
    resources :tags, only: [:index, :show]
  end

  post '/braintree/new' => 'braintree#checkout'

  resources :bookings


  root 'welcome#home'

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
end
