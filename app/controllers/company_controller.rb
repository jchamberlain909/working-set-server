class CompanyController < ApplicationController

    def create
        company = Company.create(name:params[:name])
        company.users << current_user
        render json: {success:true ,id:company.id, name: company.name}
    end 


    


end 