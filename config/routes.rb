Rails.application.routes.draw do
  
  root 'users#new'

  resource :session, :only => [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  resources :users, :only => [:new, :create, :show, :edit, :update] do
    resource :profile, :only => [:new]
    resources :posts, :only => [:create, :index, :destroy]
    resources :friends, :only => [:index, :create, :destroy]
    resources :photos, :only => [:new, :create, :index, :show, :destroy] do
      resource :profile_photo, :only => [:update]
      resource :cover_photo, :only => [:update]
    end
    resource :newsfeed, :only => [:show]
  end

  resources :comments, :only => [:create, :destroy]
  resources :likes, :only => [:create, :destroy]

  get "/about" => "users#show"
  get "/about_edit" => "users#edit"
  get "/timeline" => "posts#index"
  get "/photos" => "static_pages#photos"
  get "/friends" => "static_pages#friends"

end
