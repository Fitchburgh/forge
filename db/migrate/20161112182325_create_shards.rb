class CreateShards < ActiveRecord::Migration[5.0]
  def change
    create_table :shards do |t|
      t.references :scene, foreign_key: true
      t.string :category
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
