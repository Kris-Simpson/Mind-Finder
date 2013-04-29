class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.integer :author
      t.string  :name
      t.string  :description
      t.boolean :passed
      t.integer :rating

      t.timestamps
    end
  end
end
