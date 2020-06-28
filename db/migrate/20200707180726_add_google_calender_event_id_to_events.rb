class AddGoogleCalenderEventIdToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :google_calender_event_id, :string 
  end
end
