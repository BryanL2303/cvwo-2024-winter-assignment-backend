class LabelsController < ApplicationController
    def createLabel
        render json: params
    end

    def getLabels
        labels = Label.all.order('label_name')

        render json: {status: 0, labels: labels}
    end

    def getPostsByLabels
        posts = Label.find_by(id: params[:id]).posts

        render json: {status: 0, posts: posts}
    end
end
