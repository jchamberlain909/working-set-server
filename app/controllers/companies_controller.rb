class CompaniesController < ApplicationController

    def index
        render json: Company.all 
    end 

    def show
        render json: Company.find(params[:id])
    end

    def create
        company = Company.create(name: params[:name])
        render json: company
    end

    def update
        company = Company.find(params[:id])
        company.update(update_params)
        render json: company
    end

    def destroy
        Company.destroy(params[:id])
        render json: {}
    end

    def update_params
        params.require(:company).permit(:name)
    end
end 