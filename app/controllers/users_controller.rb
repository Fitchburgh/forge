class UsersController < ApplicationController
  skip_before_action :check_auth

  def create
    @user = User.new(
      username: params[:username].downcase,
      token: params[:token],
      uid: params[:uid],
      google_oauth_data: params[:google_oauth_data]
    )
    if @user.save
      render json: @user
    else
      render :json => { error: 'User not created' }, status: 400
    end
  end

  def login
    @user = User.find_by uid: params[:uid]
    if @user.nil?
      render :json => 'User does not exist', :status => 404
    else
      @user.token = params[:token]
      @user.save
      render :json => @user
    end
  end
end
