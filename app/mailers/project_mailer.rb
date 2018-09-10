class ProjectMailer < ApplicationMailer
    def drawing_update
        @follower_url = params[:follower_url]
        @message = params[:message]
        mail(to:params[:email], subject: "Updated drawings for #{params[:project_name]}")
    end
end
