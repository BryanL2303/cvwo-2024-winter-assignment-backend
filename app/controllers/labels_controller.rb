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

        labels = {}

        for post in posts
            labels[post.id] = post.labels
        end

        render json: {status: 0, posts: posts, labels: labels}
    end
end
