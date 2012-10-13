class RenameAssigneeToTakerOnChores < ActiveRecord::Migration
  def change
    rename_column :chores, :assignee_id, :taker_id
  end
end
