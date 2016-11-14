#
class User < ApplicationRecord
  validates :username, :token, presence: true, uniqueness: true
end
