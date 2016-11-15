class CreateObstacles < ActiveRecord::Migration[5.0]
  def change
    create_table :obstacles do |t|
      t.json :obj
      t.references :user, foreign_key: true
      t.references :scene, foreign_key: true
      t.string :name
      t.boolean :public
      t.json :tags, default: '', null: false

      t.timestamps
    end
  end
end
