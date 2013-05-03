class DeleteHasTestsIdFromTests < ActiveRecord::Migration
  def change
    remove_column :tests, :has_tests_id
    remove_column :tests, :has_tests_type
  end
end
