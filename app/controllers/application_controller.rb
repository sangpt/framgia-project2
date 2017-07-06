class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def valid_info object
    render file: "public/404.html" unless object
  end

  def logged_in_user
    return if user_signed_in?
    flash[:danger] = t ".please_log_in"
    redirect_to sign_in_url
  end
end
