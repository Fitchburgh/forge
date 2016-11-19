class Entity < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :info, :tags, :name, presence: true

  def self.find_entity_by_input(var, params)
    var = []
    Entity.all.each do |t|
      var << t if t.tags.include?(params) || t.name.include?(params)
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
      public: params[:public],
      name: params[:name].downcase,
      tags: params[:tags].to_s.downcase
    )
  end

  def self.update_entity(var, params, auth_id)
    var.info = params[:info]
    var.user_id = auth_id
    var.game_id = params[:game_id]
    var.public = params[:public]
    var.name = params[:name].downcase
    var.tags = params[:tags].to_s.downcase
  end

  def self.find_entity_by_input(var, params)
    var = []
    Entity.all.each do |t|
      if t.tags.include?(params.downcase) || t.name.include?(params.downcase)
        var << { id: t.id, user_id: t.user_id, game_id: t.game_id, public: t.public, name: t.name, tags: t.tags }
      end
    end
    var
  end
end
