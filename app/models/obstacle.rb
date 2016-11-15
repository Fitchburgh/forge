class Obstacle < ApplicationRecord
  belongs_to :user
  belongs_to :scene
  validates :obj, :tags, :name, presence: true

  def self.find_obstacle_by_input(var, params)
    var = []
    Obstacle.all.each do |t|
      var << t.name if t.tags.include?(params) || t.name.include?(params)
    end
    var
  end
end
