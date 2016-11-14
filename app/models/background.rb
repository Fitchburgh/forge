class Background < ApplicationRecord
  belongs_to :user
  belongs_to :scene
  validates :obj, :name, presence: true
end
