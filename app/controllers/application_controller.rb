class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token

  # before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?

  include JsonWebToken

  def authenticate_user
    return unless request.headers['Authorization'].present?

    begin
      decoded = jwt_decode(request.headers['Authorization'])
      @current_user = User.find(decoded[:user_id])
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :surname, :bio, :photo, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :surname, :bio, :photo, :email, :password, :current_password)
    end
  end

  # Catch all CanCan errors and alert the user of the exception
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
