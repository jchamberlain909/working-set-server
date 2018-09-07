class CompanyController < ApplicationController

    def create
        company = Company.create(name:params[:name])
        company.users << current_user
        render json: {success:true ,
            id:company.id, name: company.name, 
            contacts:company.contacts.map{|contact| contact.email}}
    end 


    


end 