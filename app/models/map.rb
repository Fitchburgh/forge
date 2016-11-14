class Map < ApplicationRecord
  belongs_to :game
  validates :name, presence: true
end
