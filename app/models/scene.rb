class Scene < ApplicationRecord
  belongs_to :map
  validates :name, presence: true

  def self.create_scene(var, options)
    var = self.new_scene(options)
    if var.save
      var
    else
      var.errors.full_messages
    end
  end

  def self.new_scene(options)
    Scene.new(
      obj: options['obj'], map_id: options['map_id'],
      description: options['description'], name: options['name'].downcase
    )
  end
end
