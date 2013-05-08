class DeleteSomeColumns < ActiveRecord::Migration
  def change
    remove_column :tests, :passed
    remove_column :tests, :rating
  end
end
