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
  end

  private

  def user_params
    params.permit(:username, :token)
  end
end
# user.find_by_token [params[:token]]
