# README

Backend for web forum hosted on Heroku.
Ruby on Rails with Postgresql database.

Frontend can be found through the following link:
https://github.com/BryanL2303/cvwo-2024-winter-assignment-frontend

The frontend is not deployed yet, refer to the README in the frontend for guide to setup.

# Documentation

## post "/signup" => "users#signup"

params: 
    username: string
    password: string

renders: 
  	status: {
        0 - success
        1 - account username already exists
        2 - error interacting with database
    }
    token: string (Only for status === 0)
    error: string (Only for status === 2)


## post "/login" => "users#login"

params: 
    username: string
    password: string

renders: 
  	status: {
        0 - success
        1 - username/password is wrong
    }
    token: string (Only for status === 0)

## post "/auto_login" => "users#autoLogin"

params: 
    token: string

renders: 
  	status: {
        0 - success
        1 - token is unauthorised
    }
    username: string (Only for status === 0)

## post "/get_labels" => "labels#getLabels"

renders: 
  	status: {
        0 - success
    }
    labels: label[] (Only for status === 0)

## post "/get_posts_by_labels" => "labels#getPostsByLabels"

params:
    id: string (id of the label)

renders: 
  	status: {
        0 - success
    }
    posts: post[] (Only for status === 0, the posts which belong to the label id provided)
    labels: label[] (Only for status === 0, the other labels which belongs to the posts returned as each post can have more than 1 label)

## post "/create_post" => "posts#createPost"

params:
    token: string
    title: string
    labels: string[] < contains id of labels
    description: string

renders:
    status: {
        0 - success
        1 - token is not authorized
        2 - problem with database
    }
    post: post (Only for status === 0)
    error: string (Only for status === 2)

## post "/get_posts" => "posts#getAllPosts"

renders: 
  	status: {
        0 - success
    }
    posts: post[] (Only for status === 0, all posts ordered by id/date of creation)
    labels: label{key: post.id, value: label[]} (Only for status === 0, all labels which belongs to the posts returned)

## post "/get_post" => "posts#getPost"

renders: 
  	status: {
        0 - success
    }
    post: post (Only for status === 0, all posts ordered by id/date of creation)
    labels: label[] (Only for status === 0, all labels which belongs to the post requested)

## post "/update_post" => "posts#updatePost"

params:
    id: string < id of post to update
    token: string
    title: string
    labels: string[] < contains id of labels
    description: string

renders:
    status: {
        0 - success
        1 - token is not authorized
        2 - problem with database
    }
    error: string (Only for status === 2)

## post "/delete_post" => "posts#deletePost"

params:
    id: string < id of post to delete
    token: string

renders:
    status: {
        0 - success
        1 - token is not authorized
        2 - problem with database
    }

## post "/post_comment" => "comments#postComment"

params:
    variant: string < "post" || "comment"
    id: string < id of comment/post depending on variant
    token: string
    comment: string

renders:
    status: {
        0 - success
        1 - token is not authorized
        2 - problem with database
    }
    error: string (Only for status === 2)

## post "/update_comment" => "comments#updateComment"

params:
    id: string < id of comment to update
    token: string
    updates: string < updated comment

renders:
    status: {
        0 - success
        1 - token is not authorized
        2 - problem with database
    }
    error: string (Only for status === 2)

## post "/get_comments" => "comments#getComments"

params:
    variant: string < "post" || "comment"
    id: string < id of comment/post depending on variant

renders:
    status: {
        0 - success
    }
    comments: comment[]
    hasChild: boolean < To indicate if there are replies to this comment

## post "/delete_comment" => "comments#deleteComment"

params:
    id: string < id of comment to delete
    token: string

renders:
    status: {
        0 - success
        1 - token is not authorized
        2 - problem with database
    }

# Project Status

Further improvements to be made:
1. Validate parameters before performing actions, return error otherwise
2. Filling in missing documentations for each function in the controllers
3. Instead of using post request for everything switch to get for unnecessary requests.