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
            if params[:variant] == "post"
                comment = Comment.new(user_id: user.id, comment: params[:comment], post_id: params[:id])
            elsif params[:variant] == "comment"
                comment = Comment.new(user_id: user.id, comment: params[:comment], parent_comment_id: params[:id])
            else
                render json: {status: 2, error: comment.errors.messages}
            end

            if comment.save
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

        if user.id != comment.user_id
            render json: {status: 1}
        else
            comment.comment = comment.comment + "\nedited: \n" + params[:updates]
            if comment.save
                render json: {status: 0, comment: comment}
            else
                render json: {status: 2, error: comment.errors.messages}
            end
        end
    end

    # Retrieve all comments for a post:
    # post_id: string
    # 
    # Backend should respond with status:
    # 0 - success
    # 2 - problem with database
    def getComments
        comments = []
        if params[:variant] == "post"
            comments = Comment.where(post_id: params[:id])
        end
        if params[:variant] == "comment"
            comments = Comment.where(parent_comment_id: params[:id])
        end

        for comment in comments
            childComments = Comment.find_by(parent_comment_id: comment.id)
            comment['hasChild'] = (childComments != nil)
        end

        render json: {status: 0, comments: comments}
    end
end
