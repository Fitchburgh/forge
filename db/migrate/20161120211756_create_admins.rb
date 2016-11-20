class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :username
      t.string :first
      t.string :last
      t.boolean :active, default: true
      t.string :email
      t.string :password_digest
      t.string :api_key

      t.timestamps
    end
  end
end
