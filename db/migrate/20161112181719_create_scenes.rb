class CreateScenes < ActiveRecord::Migration[5.0]
  def change
    create_table :scenes do |t|
      t.references :map, foreign_key: true
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
