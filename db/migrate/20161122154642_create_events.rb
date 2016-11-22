class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.json :info
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.string :name
      t.string :category
      t.boolean :published, default: false
      t.json :tags, default: '', null: false

      t.timestamps
    end
  end
end
