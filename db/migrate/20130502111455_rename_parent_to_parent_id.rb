class RenameParentToParentId < ActiveRecord::Migration
  def change
    rename_column :rooms, :parent, :parent_id
  end
end
