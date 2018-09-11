class CompanyController < ApplicationController
    before_action :authorize
    skip_before_action :authorize, only: [:create, :show]

    def show
        if current_user.company == nil
            render json: {success:true, company: nil}            
        end
        company = current_user.company
        render json: {
            success: true,
            company: {
                id: company.id,
                name: company.name,
                contacts: company.contacts.map{|contact| contact.email},
                users: company.users.map{|user|{id:user.id, name:user.name, email:user.email}}
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

    def update
        company = Company.find(params[:id])
        company.update(params.permit(:name))
        render json: {
            success: true,
            company: {
                id: company.id,
                name: company.name,
                contacts: company.contacts.map{|contact| contact.email},
                users: company.users.map{|user|{id:user.id, name:user.name, email:user.email}}
            }
        }
    end

    private 

    def authorize
        if current_user.company_id != params[:id].to_i
            render json: {success: false, message: "You are not authorized to view this resource"}
        end
    end
    
end 