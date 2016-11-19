# This will really only be needed if loading game JSON info is too slow
class Map < ApplicationRecord
  belongs_to :game
  validates :name, presence: true, uniqueness: { scope: :game }

  def self.create_map(var, params)
    var = self.new_map(params)
    if var.save
      var
    else
      var.errors.full_messages
    end
  end

  def self.new_map(params)
    Map.create(
      info: params[:info], game_id: params[:game_id],
      description: params[:description], name: params[:name].downcase
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
