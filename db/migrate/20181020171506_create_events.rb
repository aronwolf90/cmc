class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string     :title, null: false
      t.datetime   :start_time
      t.daterange  :duration
      t.boolean    :all_day, null: false, default: false

      t.timestamps
    end
  end
end
