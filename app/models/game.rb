require 'pry'
class Game < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true

  def self.create_new_game(var, params, auth_id)
    var = self.new_game(params, auth_id)
  end

  def self.new_game(params, auth_id)
    Game.new(
      name: params[:name].downcase,
      tags: params[:tags].to_s.downcase,
      description: params[:description].downcase,
      info: params[:info],
      user_id: auth_id,
      published: params[:published],
      plays: 0
    )
  end

  def self.find_game_by_input(var, params)
    var = []
    Game.all[1..-1].each do |t|
      if t.tags.include?(params.downcase) || t.name.include?(params.downcase)
        binding.pry
        var << {id: t.id, name: t.name, tags: t.tags, user_id: t.user_id, description: t.description, published: t.published, plays: t.plays}
      end
    end
    var
  end

  def self.update_game(var, params)
    var.name = params[:name].downcase
    var.tags = params[:tags].to_s.downcase
    var.description = params[:description].downcase
    var.info = params[:info]
    var.published = params[:published]
  end
end
