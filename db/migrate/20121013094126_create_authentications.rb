class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider, :null => false
      t.string :uid, :null => false
      t.integer :user_id
      t.string :token
      t.string :secret
      t.timestamps
    end
    add_index :authentications, [:provider, :uid]
    add_index :authentications, [:user_id]
  end
end