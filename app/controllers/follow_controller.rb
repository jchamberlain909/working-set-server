class FollowController < ApplicationController 
    before_action :authorize
    skip_before_action :authenticate, only: [:download]
    skip_before_action :authorize, only: [:download]

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

    def download
        hashids = Hashids.new("this is my salt", 8)
        follow = Follow.find(hashids.decode(params[:follow_id])[0])
        
        follow.update(up_to_date: true)
        redirect_to follow.project.drawing_link
    end 

    private 

    def authorize
        @project = Project.find(params[:project_id])
        if current_user.company_id != @project.company_id
            render json: {success: false, message: "You are not authorized to view this resource"}
        end
    end 

end 