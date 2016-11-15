#
class Game < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true

  # This is not working properly - moved to controller, will want to refactor it here.
  def self.keyword_search(input)
    @games = []
    games = Game.all
    games.each do |t|
      @games << t.name if t.tags.include?(input)
    end
  end
end
