class RenamePictureToImageOnSpaces < ActiveRecord::Migration
  def change
    rename_column :spaces, :picture, :image
  end
end
