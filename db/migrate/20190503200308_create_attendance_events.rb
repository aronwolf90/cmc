class CreateAttendanceEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :attendance_events do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.date :from_day, null: false
      t.date :to_day, null: true
      t.time :from_time, null: true
      t.time :to_time, null: true
      t.string :description, null: true

      t.timestamps
    end
  end
end
