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

  def self.create_entity_article(var, options)
    var = self.new_entity(options)
  end

  def self.new_entity(options)
    Entity.new(
      obj: options[:obj],
      user_id: request.env['HTTP_USER_ID'].to_i,
      game_id: options[:game_id],
      public: options[:public],
      name: options[:name].downcase,
      tags: options[:tags].to_s.downcase
    )
  end

  def self.update_entity(var, params)
    var.obj = params[:obj]
    var.user_id = request.env['HTTP_USER_ID'].to_i
    var.game_id = params[:game_id]
    var.public = params[:public]
    var.name = params[:name].downcase
    var.tags = params[:tags].downcase
  end
end
