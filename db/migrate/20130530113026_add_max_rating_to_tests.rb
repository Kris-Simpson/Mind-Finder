class AddMaxRatingToTests < ActiveRecord::Migration
  def change
    add_column :tests, :max_rating, :integer
  end
end
