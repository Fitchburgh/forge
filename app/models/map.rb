# This will really only be needed if loading game JSON obj is too slow
class Map < ApplicationRecord
  belongs_to :game
  validates :name, presence: true

  def self.create_map(var, options)
    var = self.new_map(options)
    if var.save
      var
    else
      var.errors.full_messages
    end
  end

  def self.new_map(options)
    Map.new(
      obj: options['obj'], game_id: options['game_id'],
      description: options['description'], name: options['name'].downcase
    )
  end
end
