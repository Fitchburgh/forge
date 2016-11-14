class Shard < ApplicationRecord
  belongs_to :scene
  validates :category, :name, presence: true 
end
