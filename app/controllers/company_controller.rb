class CompanyController < ApplicationController
    before_action :authorize
    skip_before_action :authorize, only: [:create, :show, :add_user]
    skip_before_action :authenticate, only: [:add_user]

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

    def add_user
        puts params
        hashids = Hashids.new("this is my salt", 8)
        decoded = hashids.decode(params[:invite_id])
        company = Company.find(decoded[0])
        user = User.find(decoded[1])
        company.users << user 
        redirect_to 'localhost:3001/login'
    end

    def invite_user
        user = User.find_by(email:params[:email])
        if user == nil
            render json: {success: false, message: "There is no user with this email"}
        end
        hashids = Hashids.new("this is my salt", 8)
        company = Company.find(params[:id])
        join_link = "localhost:3000/invite/#{hashids.encode(company.id,user.id)}"
        CompanyMailer.with(email: params[:email],
                            company_name: company.name,
                            join_link: join_link ).user_invite.deliver_later
        render json: {success: true}

    end

    def remove_user
        user = User.find(params[:user_id])
        company = Company.find(params[:id])
        company.users.delete(user)
        render json: {success: true}
    end

    private 

    def authorize
        if current_user.company_id != params[:id].to_i
            render json: {success: false, message: "You are not authorized to view this resource"}
        end
    end
    
end 