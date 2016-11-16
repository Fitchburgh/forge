class User < ApplicationRecord
  validates :username, :token, :uid, presence: true, uniqueness: true

  def self.find_user
    @username = Redis.current.get(@user.username)
    @token = Redis.current.get(@user.token)
    @uid = Redis.current.get(@user.uid)
    @google_oauth_data = Redis.current.get(@user.google_oauth_data)
    return {
      username: @username,
      token: @token,
      uid: @uid,
      google_oauth_data: @google_oauth_data
    }
  end

  def self.search_and_save_user(user)
    Redis.current.set(user.attributes["username"], user.attributes.to_json)
  end
end
