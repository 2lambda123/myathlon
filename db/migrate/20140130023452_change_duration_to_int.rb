class ChangeDurationToInt < ActiveRecord::Migration
  def change
    add_column :exercises, :seconds, :integer
    remove_column :exercises, :duration
    rename_column :exercises, :seconds, :duration
  end
end
