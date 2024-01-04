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

    def getAllPosts
        #posts = Post.all.joins(:labels).order('id')
        posts = Post.includes(:labels).all.order('id')

        labels = {}

        for post in posts
            labels[post.id] = post.labels
        end

        render json: {status: 0, posts: posts, labels: labels}
    end

    def getPost
        post = Post.find_by(id: params[:id].to_i)

        render json: {status: 0, post: post}
    end

    def updatePost
        post = Post.find_by(id: params[:id].to_i)

        user = authorised_user(params[:token])
        if user == nil
            render json: {status: 1}
        else
            if user.id == post.user_id
                post.title = params[:title]
                datetime = DateTime.now
                date = datetime.strftime("%d %B %Y")
                post.description = "[Edited " + date + "] \n" + params[:description]
                if post.save
                    render json: {status: 0}
                else
                    render json: {status: 2}
                end
            else
                render json: {status: 1}
            end
        end
    end

    def deletePost
        post = Post.find_by(id: params[:id].to_i)

        user = authorised_user(params[:token])
        if user == nil
            render json: {status: 1}
        else
            if user.id == post.user_id
                comments = Comment.where(post_id: post.id)
                comments.destroy_all
                if post.destroy
                    render json: {status: 0}
                else
                    render json: {status: 2}
                end
            else
                render json: {status: 1}
            end
        end
    end
end
