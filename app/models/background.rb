class Background < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :obj, :tags, :name, presence: true

  def self.find_background_by_input(var, params)
    var = []
    Background.all.each do |t|
      var << t if t.tags.include?(params) || t.name.include?(params)
    end
    var
  end

  def self.create_background_article(var, options, auth_id)
    var = self.new_background(options, auth_id)
  end

  def self.new_background(options, auth_id)
    Background.new(
      obj: options[:obj],
      user_id: auth_id,
      game_id: options[:game_id],
      public: options[:public],
      name: options[:name].downcase,
      tags: options[:tags].to_s.downcase
  )
  end

  def self.update_background(var, params, auth_id)
    var.obj = params[:obj]
    var.user_id = auth_id
    var.game_id = params[:game_id]
    var.public = params[:public]
    var.name = params[:name].downcase
    var.tags = params[:tags].downcase
  end

  def self.find_background_by_input(var, params)
    var = []
    Background.all.each do |t|
      if t.tags.include?(params.downcase) || t.name.include?(params.downcase)
        var << t
      end
    end
    var
  end
end
