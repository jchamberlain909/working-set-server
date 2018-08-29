class ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods

    def current_user
        authenticate_or_request_with_http_token do |jwt_token, options|
          begin
            decoded_token = JWT.decode(jwt_token, Rails.application.credentials.jwt[:secret])
    
          rescue JWT::DecodeError
            return nil
          end
    
          if decoded_token[0]["user_id"]
            @current_user = User.find(decoded_token[0]["user_id"])
          else
            
          end
        end
    end

    def authenticate
      @current_user ||= current_user
    end
    
    def logged_in?
      !!current_user
    end
end
