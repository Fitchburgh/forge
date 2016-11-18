class Game < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true

  def self.find_game_by_input(var, params)
    var = []
    Game.all[1..-1].each do |t|
      if t.tags.include?(params.downcase) || t.name.include?(params.downcase)
        var << {id: t.id, name: t.name, tags: t.tags, user_id: t.user_id, description: t.description, public: t.public}
      end
    end
    var
  end
end
