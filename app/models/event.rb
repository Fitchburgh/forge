class Event < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validates :info, :category, :tags, :name, presence: true

  def self.create_event_article(var, params, auth_id)
    var = self.new_event(params, auth_id)
  end

  def self.find_event_by_input(var, params)
    var = []
    Event.all.each do |t|
      if t.tags.include?(params.downcase) || t.name.include?(params.downcase)
        var << { category: t.category, id: t.id, user_id: t.user_id, game_id: t.game_id, published: t.published, name: t.name, tags: t.tags }
      end
    end
    var
  end

  def self.create_event_article(var, params, auth_id)
    var = self.new_event(params, auth_id)
  end

  def self.new_event(params, auth_id)
    Event.new(
      info: params[:info],
      user_id: auth_id,
      game_id: params[:game_id],
      published: params[:published],
      name: params[:name].downcase,
      tags: params[:tags].to_s.downcase,
      category: params[:category].downcase
    )
  end

  def self.update_event(var, params, auth_id)
    var.info = params[:info]
    var.user_id = auth_id
    var.game_id = params[:game_id]
    var.published = params[:published]
    var.name = params[:name].downcase
    var.tags = params[:tags].to_s.downcase
    var.category params[:category].downcase
  end

  def self.find_event_by_game(var, params)
    var = []
    Event.where(game_id: params).each do |t|
      var << t
    end
    var
  end
end
