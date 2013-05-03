class AddHasTestsIdToTests < ActiveRecord::Migration
  def change
    add_column :tests, :has_tests_id, :integer
    add_column :tests, :has_tests_type, :string
  end
end
