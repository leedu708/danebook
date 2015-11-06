Rails.application.routes.draw do
  
  root 'users#new'

  resource :session, :only => [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  resources :users, :only => [:new, :create, :show, :edit, :update] do
    resource :profile, :only => [:new]
    resources :posts, :only => [:create, :index, :destroy]
  end

  resources :likes, :only => [:create, :destroy]
  resources :comments, :only => [:create]

  get "/about" => "users#show"
  get "/about_edit" => "users#edit"
  get "/timeline" => "posts#index"
  get "/photos" => "static_pages#photos"
  get "/friends" => "static_pages#friends"

end
