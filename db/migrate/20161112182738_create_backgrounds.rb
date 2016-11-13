class CreateBackgrounds < ActiveRecord::Migration[5.0]
  def change
    create_table :backgrounds do |t|
      t.json :obj
      t.references :user, foreign_key: true
      t.references :shard, foreign_key: true
      t.boolean :public
      t.json :tags

      t.timestamps
    end
  end
end
