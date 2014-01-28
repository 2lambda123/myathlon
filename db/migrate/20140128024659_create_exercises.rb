class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :type
      t.boolean :outdoor
      t.float :distance
      t.time :duration
      t.integer :user_id

      t.timestamps
    end
    add_index :exercises, :user_id
  end
end
