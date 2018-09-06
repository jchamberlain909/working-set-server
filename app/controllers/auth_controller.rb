class AuthController < ApplicationController
    skip_before_action :authenticate

    def login
        email = params[:email]
        password = params[:password]

        user = User.find_by(email: email)

        if user && user.authenticate(password)
            render json: {success:true, id: user.id, name: user.name, email: user.email,company:user.company, projects:user.projects, token: generate_token(user) }

        else 
            render json: { success: false, message: "Incorrect email/password" }, status: 401
        end 
    end 

    def signup
        @current_user = User.create(email: params[:email], 
            name: params[:name], password: params[:password],
            password_confirmation: params[:password_confirmation])
        
        if @current_user.valid?
            render json: {success: true,id: @current_user.id, name: @current_user.name, email: @current_user.email,company:@current_user.company, projects:@current_user.projects, token: generate_token(@current_user)}
        else 
            error_message = ""
            @current_user.errors.full_messages.each{|message|error_message+=(message+", ")}
            render json: {success: false, message: error_message}
        end

        
    end 


    private
    def generate_token(user)
        alg = 'HS256'
        secret = Rails.application.credentials.jwt[:secret]
        payload = { user_id: user.id }
        JWT.encode payload, secret, alg
    end

end 