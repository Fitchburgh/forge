class Background < ApplicationRecord
  belongs_to :user
  belongs_to :scene
  validates :obj, :tags, :name, presence: true
end
