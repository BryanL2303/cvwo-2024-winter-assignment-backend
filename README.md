# README

Backend for web forum hosted on Heroku with docker.
Ruby on Rails with Postgresql database.

Frontend can be found through the following link:
https://github.com/BryanL2303/cvwo-2024-winter-assignment-frontend

The frontend is deployed, refer to the link below:
https://cvwo-web-forum-frontend-a8f77debc888.herokuapp.com/

# Setting up on local machine

Install the project locally
Rename `.env.example` file to `.env`
Open .env file and fill in the fields
Run the following commands to set up in production environment:
### `docker-compose build`
### `docker-compose run rails bin/rails db:migrate`
### `docker-compose run rails bin/rails db:seed`
### `docker-compose up`

The backend API should now be listening on port 3000

To stop the server run:
### `docker-compose down`

To reset the database (delete the current volume) run:
### `docker-compose down -v`
Doing so will mean that user needs to re run migration and seed

# Deployment on Heroku with Docker

This project is up and running as a container on Heroku with container stack

Heroku stack can be switched from Heroku-22 with the following command:
### `heroku stack:set container --app [name of app on Heroku]`

# Documentation for API

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
1. Filling in missing documentations for each function in the controllers
2. Instead of using post request for everything switch to get for unnecessary requests.