class CreateBackgrounds < ActiveRecord::Migration[5.0]
  def change
    create_table :backgrounds do |t|
      t.json :info
      t.references :user, foreign_key: true
      t.references :game, foreign_key: true
      t.boolean :public, default: true
      t.string :name
      t.json :tags, default: '', null: false

      t.timestamps
    end
  end
end
