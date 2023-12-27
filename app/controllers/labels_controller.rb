class LabelsController < ApplicationController
    def createLabel
        render json: params
    end

    def getLabels
        labels = Label.all.order('label_name')
    end
end
