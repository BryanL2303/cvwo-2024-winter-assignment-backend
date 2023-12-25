Rails.application.routes.draw do
  resources :users
  resources :labels
  resources :posts 
  resources :comments
#  post "/signup", to: "users#create"
#  post "/login", to: "users#login"
#  patch "/users/:id", to: "users#update"
#  get "/users/:id", to: "users#show"
#  get "/auto_login", to: "users#auto_login"
  post "/signup", to: "users#signup"
  post "/login" => "users#login"
  post "/create_label" => "labels#createLabel"
  post "/post_comment" => "comments#postComment"
  post "/update_comment" => "comments#updatecomment"
  post "/get_comments" => "comments#getComments"
end
