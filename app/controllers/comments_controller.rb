class CommentsController < ApplicationController
    def postComment
        render json: params
    end

    def updateComment
        render json: params
    end

    def getComments
        render json: params
    end
end
