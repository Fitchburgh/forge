#
class Game < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true

  def self.keyword_search(input)
    @games = []
    games = Game.all
    games.each do |t|
      @games << t.name if t.tags.include?(input)
    end
    return @games
    binding.pry
  end
end
