Rails.application.routes.draw do
  
  get 'users/index'

  #投稿系ルーティング
  post 'posts/create' => "posts#create"
  post 'posts/:id/update' => "posts#update"
  post 'posts/:id/destroy' => "posts#destroy"
  get 'posts/index' => "posts#index"
  get 'posts/new' => "posts#new"
  get 'posts/:id' => "posts#show"
  get 'posts/:id/edit' => "posts#edit"
 
  #ユーザー系ルーティング
  post 'users/create' => "users#create"
  post 'users/:id/update' => "users#update"
  post 'users/:id/destroy' => "users#destroy"
  get 'users/index' => "users#index"
  get 'signup' => "users#new"
  get 'users/:id' => "users#show"
  get 'users/:id/edit' => "users#edit"
  
  #topとabout
  get '/' => "home#top"
  get 'about' => "home#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
