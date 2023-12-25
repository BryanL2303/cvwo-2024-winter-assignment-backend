class LabelsController < ApplicationController
    def createlabel
        render json: params
    end
end
