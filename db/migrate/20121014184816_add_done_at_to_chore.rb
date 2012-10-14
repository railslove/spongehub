class AddDoneAtToChore < ActiveRecord::Migration
  def change
    add_column :chores, :done_at, :timestamp
  end
end
