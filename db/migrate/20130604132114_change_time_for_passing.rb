class ChangeTimeForPassing < ActiveRecord::Migration
  def change
    change_column :tests, :time_for_passing, :float
  end
end
