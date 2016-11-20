class AddPlaysToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :plays, :integer
  end
end
