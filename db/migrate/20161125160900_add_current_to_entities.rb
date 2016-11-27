class AddCurrentToEntities < ActiveRecord::Migration[5.0]
  def change
    add_column :entities, :current, :boolean, default: false
  end
end
