class AddRatingRoundToTests < ActiveRecord::Migration
  def change
    add_column :tests, :rating_round, :integer
  end
end
