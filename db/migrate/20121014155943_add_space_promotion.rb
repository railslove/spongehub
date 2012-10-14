class AddSpacePromotion < ActiveRecord::Migration
  def up
    add_column :spaces, :promote, :boolean, default: false
  end

  def down
    remove_column :spaces, :promote
  end
end
