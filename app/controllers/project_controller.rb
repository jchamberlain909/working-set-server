class ProjectController < ApplicationController 
    before_action :authorize
    skip_before_action :authorize, only: [:create]

    def show
        render json: {
            success: true,
            id:@project.id,
            name: @project.name
            drawing_link: @project.drawing_link
            last_updated: @project.updated_at
        }
    end 

    def create
        project = Project.create(params.permit(:name,:drawing_link)
        current_user.company.projects << project 
        render json: {success: true, id: project.id, 
                        name: project.name, drawing_link:project.drawing_link,
                        last_updated: project.last_updated
                    }
    end

    def update
        @project.update(params.permit(:name, :drawing_link))

        render json: {
            success: true,
            id:@project.id,
            name: @project.name
            drawing_link: @project.drawing_link
            last_updated: @project.updated_at
        }
    end

    private 
    def authorize
        @project = Project.find(params[:id])
        if current_user.company_id != @project.company_id
            render json: {success: false, message: "You are not authorized to view this resource"}
        end
    end 

end 