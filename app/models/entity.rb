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
end
