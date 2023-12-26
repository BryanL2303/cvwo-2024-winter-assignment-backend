class PostsController < ApplicationController
    def createPost
        render json: params
    end

    def update
        render json: params
    end

    def show
        render json: params
    end

    def delete
        render json: params
    end

    def getAllPosts
        posts = Post.all.order('created_at')
        render json: posts
    end
end
