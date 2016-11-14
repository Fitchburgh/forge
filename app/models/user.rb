class User < ApplicationRecord
  validates :username, :token, :uid, :google_oauth_data, presence: true, uniqueness: true
end
