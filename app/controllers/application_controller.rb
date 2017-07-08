class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def valid_info object
    render file: "public/404.html" unless object
  end

  def logged_in_user
    return if user_signed_in?
    flash[:danger] = t ".please_log_in"
    redirect_to sign_in_url
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit :name, :email, :password, :password_confirmation
    end
  end
end
