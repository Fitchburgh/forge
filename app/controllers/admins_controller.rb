#
class AdminsController < ApplicationController
  skip_before_action :check_auth

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def new
    @admin = Admin.new
  end

  def create
    @api_key = 'yazua_key_' + SecureRandom.urlsafe_base64
    @admin = Admin.new(admin_params)
    @admin.api_key = @api_key
    if @admin.save
      session[:admin_id] = @admin.id
      redirect_to @admin, alert:  "#{@admin.username} created successfully."
    else
      redirect_to new_admin_path, alert: 'Error creating admin.'
    end
  end

  def show
    @admin = Admin.find(session[:admin_id])
  end

  def index
  end

  private

  def admin_params
    params.require(:admin).permit(
      :first, :last, :email, :password_confirmation, :password, :username
    )
  end
end
