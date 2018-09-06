class ProjectController < ApplicationController 
    before_action :authorize
    skip_before_action :authorize, only: [:create]

    def show
        render json: {
            success: true,
            id:@project.id,
            name: @project.name,
            drawings: @project.drawings
        }
    end 

    def create
        project = Project.create(name: params[:name])
        current_user.company.projects << project 
        render json: {success: true, id: project.id, name: project.name}
    end

    private 
    def authorize
        @project = Project.find(params[:id])
        if current_user.company_id != @project.company_id
            render json: {success: false, message: "You are not authorized to view this resource"}
        end
    end 

end 