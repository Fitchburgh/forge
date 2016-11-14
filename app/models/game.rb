class Game < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true

  def keyword_search(user_input)
    @games = Game.where(tags: includes(user_input))
  end
end
