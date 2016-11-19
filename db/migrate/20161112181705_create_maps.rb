class CreateMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :maps do |t|
      t.references :game, foreign_key: true
      t.string :name
      t.string :description
      t.json :info

      t.timestamps
    end
  end
end
