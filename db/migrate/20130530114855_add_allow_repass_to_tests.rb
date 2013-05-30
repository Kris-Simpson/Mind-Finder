class AddAllowRepassToTests < ActiveRecord::Migration
  def change
    add_column :tests, :allow_repass, :boolean
  end
end
