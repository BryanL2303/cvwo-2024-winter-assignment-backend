class LabelsController < ApplicationController
    def createLabel
        render json: params
    end
end
