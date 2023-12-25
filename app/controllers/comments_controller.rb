class CommentsController < ApplicationController
    def postcomment
        render json: params
    end

    def updatecomment
        render json: params
    end

    def getcomments
        render json: params
    end
end
