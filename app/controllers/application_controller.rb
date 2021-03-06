class ApplicationController < ActionController::Base
  before_action :check_auth

  def check_auth
    user_id = request.env['HTTP_USER_ID'].to_i
    if user_id.nil?
      render json: "No User ID Detected", status: 401
    else
      current_user = User.find(user_id)
      if current_user.token == request.env['HTTP_TOKEN']
        true
      else
        render json: "User not logged in", status: 401
      end
    end
  end
end
