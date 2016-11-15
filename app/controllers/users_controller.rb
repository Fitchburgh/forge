#
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.json { render json: @user.id }
      else
        format.json { render text: 'User not created' }
      end
    end
  end

  def current_user
    User.find_by token: params[:token]
  end

  def login
    @user = User.find_by uid: params[:uid]
    if @user.nil?
      render :json => 'User does not exist'
    else
      @user.token = params[:token]
      @user.save
      render :json => @user.username
    end
  end

  private

  def user_params
    params.permit(:username, :token, :uid, :google_oauth_data)
  end
end
