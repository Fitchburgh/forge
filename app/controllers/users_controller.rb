#
class UsersController < ApplicationController
  def create
    @user = User.new(
      username: params[:username].downcase,
      token: params[:token],
      uid: params[:uid],
      google_oauth_data: params[:google_oauth_data]
    )
    respond_to do |format|
      if @user.save
        format.json { render json: @user }
      else
        format.json { render text: 'User not created' }
      end
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
