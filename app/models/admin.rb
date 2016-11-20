require 'securerandom'
#
class Admin < ApplicationRecord

  before_save :downcase_names
  validates_presence_of :first, :last, :email, :username, :password
  has_secure_password
  #validates :username
  #validate :email # does not exist currently in db
  validates :username, length: { minimum: 4, maximum: 25 }

  private

  def downcase_names
    self.username = username.downcase
    self.first = first.downcase
    self.last = last.downcase
  end

  def username_exists

  end

  def email_exists

  end
end
