Myblog::Application.routes.draw do
  root :to => "posts#index"
  get '/search', :to => 'posts#index', :as => :search
  match '/signup', :to => 'users#new'
  match '/login',  :to => 'sessions#new'
  match '/logout', :to => 'sessions#destroy', :via => :delete  
  resources :sessions, :only => [:new, :create, :destroy]
  resources :users, :except => [:index]
  resources :blogs, :except => [:index, :show]
  resources :posts, :only => [:new, :create] do
    resources :comments, :only => [:create, :destroy]
  end
  delete '/:user_name/:post_permalink', :to => 'posts#destroy', :as => :delete_post
  get '/:user_name/:post_permalink', :to => 'posts#show', :as => :post
  get '/:user_name/:post_permalink/edit', :to => 'posts#edit', :as => :edit_post
  put '/:user_name/:post_permalink', :to => 'posts#update', :as => :post
  get '/:user_name/', :to => 'posts#user_name_index', :as => :user_posts  
  get '/users/password/:id', :to => 'users#new_password', :as => :new_password_user
  put '/users/password/:id', :to => 'users#update_password', :as => :update_password_user
end
