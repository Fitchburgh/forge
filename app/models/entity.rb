class Entity < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :obj, :tags, :name, presence: true

  def self.find_entity_by_input(var, params)
    var = []
    Entity.all.each do |t|
      var << t if t.tags.include?(params) || t.name.include?(params)
    end
    var
  end

  def self.create_entity_article(var, options, auth_id)
    var = self.new_entity(options)
  end

  def self.new_entity(options, auth_id)
    Entity.new(
      obj: options[:obj],
      user_id: auth_id,
      game_id: options[:game_id],
      public: options[:public],
      name: options[:name].downcase,
      tags: options[:tags].to_s.downcase
    )
  end

  def self.update_entity(var, params, auth_id)
    var.obj = params[:obj]
    var.user_id = auth_id
    var.game_id = params[:game_id]
    var.public = params[:public]
    var.name = params[:name].downcase
    var.tags = params[:tags].downcase
  end
end
