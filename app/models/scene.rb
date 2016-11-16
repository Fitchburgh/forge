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
      obj: options['obj'], map_id: options['map_id'], game_id: options['game_id'],
      description: options['description'], name: options['name'].downcase
    )
  end
end
