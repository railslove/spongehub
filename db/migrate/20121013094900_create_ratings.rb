class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :text
      t.integer :value
      t.integer :space_id
      t.integer :creator_id
      t.integer :rated_id
      t.integer :chore_id
      t.string :image

      t.timestamps
    end
  end
end
