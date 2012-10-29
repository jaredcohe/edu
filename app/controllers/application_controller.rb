class ApplicationController < ActionController::Base
  protect_from_forgery
  
private

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user   # to access this method from the view

  def authorize
    redirect_to login_url, alert: "Not Authorized" if current_user.nil?
  end
  
end