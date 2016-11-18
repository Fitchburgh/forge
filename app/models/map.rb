# This will really only be needed if loading game JSON obj is too slow
class Map < ApplicationRecord
  belongs_to :game
  validates :name, presence: true, uniqueness: { scope: :game }

  def self.create_map(var, options)
    var = self.new_map(options)
    if var.save
      var
    else
      var.errors.full_messages
    end
  end

  def self.new_map(options)
    Map.create(
      obj: options['obj'], game_id: options['game_id'],
      description: options['description'], name: options['name'].downcase
    )
  end

  def self.find_map_by_input(var, params)
    var = []
    Map.all.each do |map|
      var << {  id: map.id, game_id: map.game_id, name: map.name, description: map.description } if map.name.include?(params)
    end
    var
  end
end
