class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      cookies[:auth_token] = user.auth_token
      redirect_to root_url, :notice => "Logged in!"
    else
      render "new"
    end
  end
  
  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, notice: "logged out"
  end
end
