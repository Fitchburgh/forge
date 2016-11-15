class Obstacle < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :obj, :tags, :name, presence: true

  def self.find_obstacle_by_input(var, params)
    var = []
    Obstacle.all.each do |t|
      var << t if t.tags.include?(params) || t.name.include?(params)
    end
    var
  end

  def self.create_obstacle_article(var, options)
    var = self.new_obstacle(options)
    if var.save
      var
    else
      halt(404)
    end
  end

  def self.new_obstacle(options)
    Obstacle.new(
      obj: options['obj'].downcase, user_id: options['user_id'],
      game_id: options['game_id'], name: options['name'].downcase,
      tags: options['tags'].downcase
    )
  end
end
