class CreateSpacesUsers < ActiveRecord::Migration
  def change
    create_table :spaces_users do |t|
      t.integer :space_id
      t.integer :user_id
    end
  end
end
