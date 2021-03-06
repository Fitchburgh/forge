class Background < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :info, :tags, :name, presence: true

  def self.create_background_article(var, params, auth_id)
    var = self.new_background(params, auth_id)
  end

  def self.find_background_by_input(var, params)
    var = []
    Background.all.each do |t|
      if t.tags.include?(params.downcase) || t.name.include?(params.downcase)
        var << { thumbnail: t.thumbnail, id: t.id, user_id: t.user_id, game_id: t.game_id, published: t.published, name: t.name, tags: t.tags }
      end
    end
    var
  end

  def self.create_background_article(var, params, auth_id)
    var = self.new_background(params, auth_id)
  end

  def self.new_background(params, auth_id)
    Background.new(
      info: params[:info],
      user_id: auth_id,
      game_id: params[:game_id],
      published: params[:published],
      name: params[:name].downcase,
      tags: params[:tags].to_s.downcase,
      thumbnail: params[:thumbnail]
  )
  end

  def self.update_background(var, params, auth_id)
    var.info = params[:info]
    var.user_id = auth_id
    var.game_id = params[:game_id]
    var.published = params[:published]
    var.name = params[:name].downcase
    var.tags = params[:tags].to_s.downcase
    var.thumbnail = params[:thumbnail]
  end

  def self.find_background_by_game(var, params)
    var = []
    Background.where(game_id: params).each do |t|
      var << { thumbnail: t.thumbnail, id: t.id, user_id: t.user_id, game_id: t.game_id, published: t.published, name: t.name, tags: t.tags }
    end
    var
  end
end
