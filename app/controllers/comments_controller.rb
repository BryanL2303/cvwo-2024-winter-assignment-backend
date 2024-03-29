require 'date'

class CommentsController < ApplicationController
    # Create new comment with parameters:
    # token: string
    # post_id: string | null
    # parent_comment_id: integer | null
    # comment: string
    # 
    # Backend should respond with status:
    # 0 - success
    # 1 - token is not authorized
    # 2 - problem with database
    def postComment
        user = authorised_user(params[:token])

        if user == nil
            render json: {status: 1}
        else
            datetime = DateTime.now
            date = datetime.strftime("%d %B %Y")
            if params[:variant] == "post"
                comment = Comment.new(user_id: user.id, comment: params[:comment], post_id: params[:id], author: user.username, date: date)
            elsif params[:variant] == "comment"
                comment = Comment.new(user_id: user.id, comment: params[:comment], post_id: params[:post_id], parent_comment_id: params[:id], author: user.username, date: date)
            else
                render json: {status: 2, error: "The variant should either be 'post' or 'comment'"}
            end

            if comment.valid?
                comment.save
                render json: {status: 0, comment: comment}
            else
                render json: {status: 2, error: comment.errors.messages}
            end

        end
    end

    # Update existing comment with parameters:
    # token: string
    # post_id: string
    # updates: string
    # 
    # Backend should respond with status:
    # 0 - success
    # 1 - token is not authorized
    # 2 - problem with database
    def updateComment
        user = authorised_user(params[:token])
        comment = Comment.find_by(id: params[:id])

        if user == nil
            render json: {status: 1}
        else
            if user.id != comment.user_id
                render json: {status: 1}
            else
                datetime = DateTime.now
                date = datetime.strftime("%d %B %Y")
                comment.comment = "[Edited " + date + "] \n" + params[:updates]
                if comment.valid?
                    comment.save
                    render json: {status: 0, comment: comment}
                else
                    render json: {status: 2, error: comment.errors.messages}
                end
            end
        end
    end

    # Retrieve all comments for a post:
    # post_id: string
    # variant: string {post || comment}
    # 
    # Backend should respond with status:
    # 0 - success
    # 2 - problem with database
    def getComments
        comments = []
        if params[:variant] == "post"
            comments = Comment.where(post_id: params[:id], parent_comment_id: nil)
        end
        if params[:variant] == "comment"
            comments = Comment.where(parent_comment_id: params[:id])
        end

        hasChild = {}

        for comment in comments
            childComments = Comment.find_by(parent_comment_id: comment.id)
            hasChild[comment.id] = childComments != nil
        end

        render json: {status: 0, comments: comments, hasChild: hasChild}
    end

    def deleteComment
        user = authorised_user(params[:token])
        comment = Comment.find_by(id: params[:id])

        if user == nil
            render json: {status: 1}
        else
            if user.id != comment.user_id
                render json: {status: 1}
            else
                comment.comment = "[deleted]"
                if comment.valid?
                    comment.save
                    render json: {status: 0, comment: comment}
                else
                    render json: {status: 2, error: comment.errors.messages}
                end
            end
        end
    end
end
