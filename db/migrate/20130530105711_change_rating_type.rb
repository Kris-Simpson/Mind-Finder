class ChangeRatingType < ActiveRecord::Migration
  def change
    change_column :passed_tests, :rating, :float
  end
end
