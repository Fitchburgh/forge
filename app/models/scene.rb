require 'pry'
class Scene < ApplicationRecord
  belongs_to :map
  belongs_to :game
  validates :name, presence: true, uniqueness: { scope: [:map, :game] }

  def self.create_scene(var, params)
    var = self.new_scene(params)
    if var.save
      var
    else
      var.errors.full_messages
    end
  end

  def self.new_scene(params)
    Scene.create(
      info: params[:info], map_id: params[:map_id], game_id: params[:game_id],
      description: params[:description], name: params[:name].downcase
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
