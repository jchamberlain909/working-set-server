class DrawingsController < ApplicationController
    skip_before_action :authenticate, only: [:download]

    before_action :authorize
    skip_before_action :authorize, only: [:create, :download]
    
    def show
        render json: @drawing
    end

    def create
        drawing = Drawing.create(type:params[:type])
        render json: drawing
    end

    def update
        @drawing.update(update_params)
    end

    def destroy
        Drawing.destroy(params[:id])
    end

    def download
        
    end

    private

    def update_params
        params.require(:drawing).permit(:type)
    end

    def authorize
        @drawing = Drawing.find(params[:id])
        if @current_user.company.id !== @drawing.project.company_id
            render json: {message:"You don't have permission to view this resource"}, status: 403
        end
    end
end 