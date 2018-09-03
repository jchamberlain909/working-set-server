class AuthController < ApplicationController
    skip_before_action :authenticate

    def login
        email = params[:email]
        password = params[:password]

        user = User.find_by(email: email)

        if user && user.authenticate(password)
            @current_user = user
            render json: { id: user.id, name: user.name, email: user.email, token: generate_token(user) }

        else 
            render json: { success: false }, status: 401
        end 
    end 

    def signup
        @current_user = User.create(email: params[:email], name: params[:name], password: params[:password])
        render json: {sucess: true, token: generate_token(@current_user)}
    end 


    private
    def generate_token(user)
        alg = 'HS256'
        secret = Rails.application.credentials.jwt[:secret]
        payload = { user_id: user.id }
        JWT.encode payload, secret, alg
    end

end 