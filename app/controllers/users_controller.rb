class UsersController < ApplicationController
    before_action :authorize
    skip_before_action :authorize, only: [:create]

    skip_before_action :authenticate, only: [:create]

    def show
        # authentication did not encounter errors
        # Decoded token matched, return user info
        render json: @current_user
    end

    def create
        user = User.create(email: params[:email], name: params[:name], password: params[:password])
        render json: user
    end

    def update
        # authentication did not encounter errors
        # Decoded token matched, return user info
        @current_user.update(update_params)
        render json: @current_user
    end

    def destroy
        # authentication did not encounter errors
        # Decoded token matched, return user info
        User.destroy(params[:id])
        render json: {}
    end

    private

    def update_params
        params.require(:user).permit(:name, :email)
    end

    def authorize
        puts @current_user.id
        puts params[:id].to_i

        if @current_user.id != (params[:id].to_i)
            render json: {message:"You don't have permission to view this resource"}, status: 403
        end
    end


end 