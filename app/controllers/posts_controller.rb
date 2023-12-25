class PostsController < ApplicationController
    def createpost
        render json: params
    end

    def updatepost
        render json: params
    end

    def getpost
        render json: params
    end

    def deletepost
        render json: params
    end
end
