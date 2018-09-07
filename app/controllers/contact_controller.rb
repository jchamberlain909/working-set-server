class ContactController < ApplicationController
    def index
        render json: current_user.company.contacts
    end 
end