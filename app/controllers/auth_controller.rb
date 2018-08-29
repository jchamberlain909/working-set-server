class AuthController < ApplicationController
    skip_before_action :authenticate

    def login
        email = params[:email]
        password = params[:password]

        user = User.find_by(email: email)

        if user && user.authenticate(password)
            render json: { success: true, token: generate_token(user) }

        else 
            render json: { success: false }
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