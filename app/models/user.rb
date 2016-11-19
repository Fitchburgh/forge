class User < ApplicationRecord
  validates :username, :token, :uid, presence: true, uniqueness: true

  def self.create_new_user(var, params)
    var = self.new_user(params)
  end

  def self.new_user(params)
    User.new(
      username: params[:username].downcase,
      token: params[:token],
      uid: params[:uid],
      google_oauth_data: params[:google_oauth_data]
    )
  end
end
