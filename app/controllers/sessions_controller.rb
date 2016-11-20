class SessionsController < ApplicationController
  skip_before_action :check_auth

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def new
  end

  def create
    @admin = Admin.find_by_email(params[:email])
    if @admin && @admin.authenticate(params[:password])
      session[:admin_id] = @admin.id
      redirect_to '/admins/show'
    else
      redirect_to '/api/login'
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to '/api/login'
  end
end
