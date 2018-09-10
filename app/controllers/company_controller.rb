class CompanyController < ApplicationController
    # before_action :authorize
    # skip_before_action :authorize, only: [:create]

    def show
        company = current_user.company
        render json: {
            success: true,
            company: {
                id: company.id,
                name: company.name,
                contacts: company.contacts.map{|contact| contact.email}
            }
        }
    end 

    def create
        company = Company.create(name:params[:name])
        company.users << current_user
        render json: {
            success: true,
            company: {
                id: company.id,
                name: company.name,
                contacts: company.contacts.map{|contact| contact.email}
            }
        }
    end 
    
end 