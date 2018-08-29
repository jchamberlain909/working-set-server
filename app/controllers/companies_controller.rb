class CompaniesController < ApplicationController
    before_action :authorize
    skip_before_action :authorize, only: [:create]

    def show
        render json: @company
    end

    def create
        company = Company.create(name: params[:name])
        company.users << @current_user
        render json: company
    end

    def update
        @company.update(update_params)
        render json: company
    end

    def destroy
        Company.destroy(params[:id])
        render json: {}
    end

    private

    def update_params
        params.require(:company).permit(:name)
    end

    def authorize
        @company = Company.find(params[:id])
        if !@company.users.include?(@current_user)
            render json: {message:"You don't have permission to view this resource"}, status: 403
        end
    end
end 