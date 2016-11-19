require 'pry'
class Scene < ApplicationRecord
  belongs_to :map
  belongs_to :game
  validates :name, presence: true, uniqueness: { scope: [:map, :game] }

  def self.create_scene(var, options)
    var = self.new_scene(options)
    if var.save
      var
    else
      var.errors.full_messages
    end
  end

  def self.new_scene(options)
    Scene.create(
      info: options['info'], map_id: options['map_id'], game_id: options['game_id'],
      description: options['description'], name: options['name'].downcase
    )
  end

  def self.find_scene_by_input(var, params)
    var = []
    Scene.all.each do |t|
      var << { name: t.name, id: t.id, map_id: t.map_id, description: t.description } if t.name.include?(params)
    end
    var
  end
end
