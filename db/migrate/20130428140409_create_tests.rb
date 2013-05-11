class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string  :name
      t.string  :description
      t.integer :room_id
      t.integer :min_shewn_questions, :integer
      t.integer :max_shewn_questions, :integer
      t.integer :time_for_passing
      t.boolean :allowed

      t.timestamps
    end
  end
end
