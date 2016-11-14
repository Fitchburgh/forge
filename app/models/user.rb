class User < ApplicationRecord
  validates :username, :token, presence: true, uniqueness: true
end

# github_oath_data:json get the UID and store the google token based on that uid
