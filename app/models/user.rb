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

  def self.find_username_by_id(games)
    users = []
    games.each do |g|
      @user = User.find_by(id: g.user_id)
      users << @user.username
    end
    users
  end
end
