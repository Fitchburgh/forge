class Entity < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :info, :tags, :name, presence: true

  def self.find_entity_by_input(var, params)
    var = []
    Entity.all.each do |t|
      if t.tags.include?(params.downcase) || t.name.include?(params.downcase)
        var << { thumbnail: t.thumbnail, current: t.current, id: t.id, user_id: t.user_id, game_id: t.game_id, published: t.published, name: t.name, tags: t.tags }
      end
    end
    var
  end

  def self.create_entity_article(var, params, auth_id)
    var = self.new_entity(params, auth_id)
  end

  def self.new_entity(params, auth_id)
    Entity.new(
      info: params[:info],
      user_id: auth_id,
      game_id: params[:game_id],
      published: params[:published],
      name: params[:name].downcase,
      tags: params[:tags].to_s.downcase,
      thumbnail: params[:thumbnail],
      current: params[:current]
    )
  end

  def self.default_entity(game_id, auth_id)
    a = Entity.find(34)
    entity = Entity.new(
      info: a.info,
      user_id: auth_id,
      game_id: game_id,
      published: false,
      name: "default",
      tags: "",
      thumbnail: a.thumbnail,
      current: true
    )
    if entity.save?
      entity
    else
      "problem"
    end
  end

  def self.update_entity(var, params, auth_id)
    var.info = params[:info]
    var.user_id = auth_id
    var.game_id = params[:game_id]
    var.published = params[:published]
    var.name = params[:name].downcase
    var.tags = params[:tags].to_s.downcase
    var.thumbnail = params[:thumbnail]
  end

  def self.find_entity_by_game(var, params)
    var = []
    Entity.where(game_id: params).each do |t|
      var << { thumbnail: t.thumbnail, current: t.current, id: t.id, user_id: t.user_id, game_id: t.game_id, published: t.published, name: t.name, tags: t.tags }
    end
    var
  end

  def self.find_entity_by_user(var, params)
    var = []
    Entity.where(user_id: params).each do |t|
      var << { thumbnail: t.thumbnail, current: t.current, id: t.id, user_id: t.user_id, game_id: t.game_id, published: t.published, name: t.name, tags: t.tags }
    end
    var
  end
end
# for these api calls. all we need to return is everything BUT info and make a separate call when they actually click the object.

# add currently_editing column boolean for all assets which will make sure that only one person can be editing one at a time
