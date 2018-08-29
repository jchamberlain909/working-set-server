class UsersController < ApplicationController

    def index
        render json: User.all
    end 

    def show
        render json: User.find(params[:id])
    end

    def create
        user = User.create(email: params[:email], name: params[:name], password: params[:password])
        render json: user
    end

    def update
        user = User.find(params[:id])
        user.update(update_params)
        render json: user
    end

    def destroy
        User.destroy(params[:id])
        render json: {}
    end

    private

    def update_params
        params.require(:user).permit(:name, :email)
    end


end 