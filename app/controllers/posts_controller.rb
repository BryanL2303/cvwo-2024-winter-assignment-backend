require 'date'

class PostsController < ApplicationController
    # Create new post with parameters:
    # token: string
    # title: string
    # labels: string[] < contains id of labels
    # description: string
    # 
    # Backend should respond with status:
    # 0 - success
    # 1 - token is not authorized
    # 2 - problem with database
    def createPost
        user = authorised_user(params[:token])

        if user == nil
            render json: {status: 1, token: token}
        else
            datetime = DateTime.now
            date = datetime.strftime("%d %B %Y")
            post = Post.new(title: params[:title], description: params[:description], author: user.username, user_id: user.id, date: date)
                
            if post.save
                for labelId in params[:labels]
                    postLabel = PostLabel.new(post_id: post.id, label_id: labelId)
                    postLabel.save
                end
                render json: {status: 0, post: post}
            else
                render json: {status: 2, error: user.errors.messages}
            end
        end
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
        posts = Post.all.order('id')

        render json: {status: 0, posts: posts}
    end

    def getPost
        post = Post.find_by(id: params[:id])

        render json: {status: 0, post: post}
    end
end
