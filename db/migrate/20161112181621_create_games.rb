class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :name
      t.json :tags
      t.references :user, foreign_key: true
      t.string :description
      t.json :info
      t.boolean :published, default: false

      t.timestamps
    end
  end
end
