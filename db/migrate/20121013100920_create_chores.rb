class CreateChores < ActiveRecord::Migration
  def change
    create_table :chores do |t|
      t.string :title
      t.text :description
      t.integer :creator_id
      t.integer :assignee_id
      t.datetime :due_at
      t.integer :space_id

      t.timestamps
    end
  end
end
