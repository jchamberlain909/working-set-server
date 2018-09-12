class CompanyMailer < ApplicationMailer
    def user_invite
        @company_name = params[:company_name]
        @join_link = params[:join_link]
        mail(to:params[:email], subject: "Invitation to join #{@company_name} on workingSet")
    end
end
