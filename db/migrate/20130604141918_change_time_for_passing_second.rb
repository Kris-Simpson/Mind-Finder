class ChangeTimeForPassingSecond < ActiveRecord::Migration
  def change
    change_column :tests, :time_for_passing, :time
  end
end
