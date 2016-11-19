class CreateSaveGames < ActiveRecord::Migration[5.0]
  def change
    create_table :save_games do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.json :info

      t.timestamps
    end
  end
end
