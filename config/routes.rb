Rails.application.routes.draw do
  
  root 'users#new'

  resource :session, :only => [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  get "/timeline" => "static_pages#timeline"
  get "/about" => "static_pages#about"
  get "/photos" => "static_pages#photos"
  get "/friends" => "static_pages#friends"
  get "/about_edit" => "static_pages#about_edit"

end
