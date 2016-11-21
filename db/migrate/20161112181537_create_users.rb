class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :token
      t.string :uid
      t.json :google_oauth_data
      t.integer :playing_game
      t.integer :editing_game

      t.timestamps
    end
  end
end
