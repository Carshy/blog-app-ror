class AuthenticationController < ApplicationController
    # skip_before_action :authenticate_user, only: :login
  
    include JsonWebToken
    # POST /auth/login
    def login
      @user = User.find_by_email(params[:email])
      if @user&.valid_password?(params[:password])
        token = jwt_encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime('%m-%d-%Y %H:%M'),
                       username: @user.name }, status: :ok
      else
        render json: { error: 'Please signup first' }, status: :unauthorized
      end
    end

    def signup
        user = User.new(name: params[:name], email: params[:email], password: params[:password])
    
        # if user is saved
        if user.save
          # we encrypt user info using the pre-defined methods in the application controller
          token = jwt_encode({ user_data: user.id })
    
          # return to user
          render json: { token: token }
        else
          # render error message
          render json: { message: 'invalid credentials' }
        end
    end
end
    
  