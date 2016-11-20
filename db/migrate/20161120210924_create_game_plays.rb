class CreateGamePlays < ActiveRecord::Migration[5.0]
  def change
    create_table :game_plays do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :plays

      t.timestamps
    end
  end
end
