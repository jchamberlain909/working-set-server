class FollowController < ApplicationController 
    before_action :authorize

    def create
        contact = Contact.find_or_create_by(
            email: params[:email],
            company_id: current_user.company_id
        )
        follow = Follow.create(
            contact_id: contact.id,
            project_id: params[:project_id],
            up_to_date: false
        )
        
        render json: {
            success: true,
            follower: {
                id: follow.id,
                email: contact.email,
                up_to_date: false
            }
        }
    end
    

    def destroy
        Follow.destroy(params[:id])
        render json: {success:true}
    end 


    private 

    def authorize
        @project = Project.find(params[:project_id])
        if current_user.company_id != @project.company_id
            render json: {success: false, message: "You are not authorized to view this resource"}
        end
    end 

end 