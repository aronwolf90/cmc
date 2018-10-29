class ChangeDurationToEndTimeOnEvent < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :duration, :datetime
    add_column :events, :end_time, :datetime
  end
end
