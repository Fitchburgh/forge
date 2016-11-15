#
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.json { render json: @user }
      else
        format.json { render text: 'User not created' }
      end
    end
  end

  def current_user
    User.find_by token: params[:token]
    # add user = to above code then process below.
    # @user_id = user.id
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

  private

  def user_params
    params.permit(:username, :token, :uid, :google_oauth_data)
  end
end
