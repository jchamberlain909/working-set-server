class ProjectsController < ApplicationController
    before_action :authorize
    skip_before_action :authorize, only: [:create]

    def show
        render json: @project
    end

    def create

        project = Project.create(name:params[:name],company_id:@current_user.company.id)
        render json: project
    end

    def update
        @project.update(params[:project])
        render json: project
    end

    def destroy
        Project.destroy(params[:id])
        render json: {}
    end

    private

    def update_params
        params.require(:project).permit(:name)
    end


    def authorize
        @project = Project.find(params[:id])
        if @current_user.company.id !== @project.company_id
            render json: {message:"You don't have permission to view this resource"}, status: 403
        end
    end


end 