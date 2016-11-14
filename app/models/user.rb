class User < ApplicationRecord
  validates :username, :token, :uid, presence: true, uniqueness: true
end
