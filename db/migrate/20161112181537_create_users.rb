class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :token
      t.string :uid
      t.json :google_oauth_data

      t.timestamps
    end
  end
end
