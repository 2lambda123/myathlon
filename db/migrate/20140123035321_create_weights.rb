class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.integer :user_id, null:false
      t.float :weight, null:false
      
      t.timestamps
    end
    add_index :weights, :user_id
  end
end
