class Background < ApplicationRecord
  belongs_to :user
  belongs_to :scene
  validates :obj, :tags, :name, presence: true

  def self.find_background_by_input(var, params)
    var = []
    Background.all.each do |t|
      var << t.name if t.tags.include?(params) || t.name.include?(params)
    end
    var
  end
end
