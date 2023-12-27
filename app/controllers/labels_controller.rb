class LabelsController < ApplicationController
    def createLabel
        render json: params
    end

    def getLabels
        labels = Label.all.order('label_name')

        render json: {status: 0, labels: labels}
    end
end
