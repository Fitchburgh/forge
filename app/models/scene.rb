class Scene < ApplicationRecord
  belongs_to :map
  validates :name, presence: true
end
