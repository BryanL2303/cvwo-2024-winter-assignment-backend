class UsersController < ApplicationController
    def signup
        render json: params
    end

    def login
        render json: params
    end
end
