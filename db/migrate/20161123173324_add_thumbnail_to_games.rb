class AddThumbnailToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :thumbnail, :text
  end
end
