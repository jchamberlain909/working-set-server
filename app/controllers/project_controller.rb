class ProjectController < ApplicationController 
    before_action :authorize
    skip_before_action :authorize, only: [:create, :index]

    def index
        render json:{
            success:true,
            projects: current_user.projects.order(updated_at: :desc).map{|project| 
                {id:project.id, name:project.name, last_updated: project.updated_at}}
        }
    end

    def show
        render json: {
            success: true,
            project: @project.serialize
        }
    end 

    def create
        project = Project.create(name: params[:name], company_id: current_user.company_id)
        if !project.valid?
            render json: {
                success: false,
                message: "Invalid Name"
            }
        else
            current_user.company.projects << project 
            render json: {
                        success: true, 
                        project: project.serialize
                    }
        end
    end

    def update

        @project.update(params.permit(:name))

        render json: {
            success: true,
            project: @project.serialize
        }
    end

    def upload
        if params[:drawing]
           @project.update(drawing: params[:drawing])
           if @project.valid?
               @project.update(drawing_link: url_for(@project.drawing))
           end
        else
            @project.update(drawing_link: params[:drawing_url])
        end

        @project.drawings_updated(params[:message])

        render json: {
            success: true,
            project: @project.serialize
        }
    end

    def destroy
        Project.destroy(params[:id])
        render json: {success: true}
    end

    private 
    def authorize
        @project = Project.find(params[:id])
        if current_user.company_id != @project.company_id
            render json: {success: false, message: "You are not authorized to view this resource"}
        end
    end 


end 