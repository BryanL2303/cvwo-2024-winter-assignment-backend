Rails.application.routes.draw do
  post "/signup" => "users#signup"
  post "/login" => "users#login"
  post "/auto_login" => "users#autoLogin"
  post "/create_label" => "labels#createLabel"
  post "/get_labels" => "labels#getLabels"
  post "/create_post" => "posts#createPost"
  post "/get_posts" => "posts#getAllPosts"
  post "/get_post" => "posts#getPost"
  post "/post_comment" => "comments#postComment"
  post "/update_comment" => "comments#updatecomment"
  post "/get_comments" => "comments#getComments"
end
