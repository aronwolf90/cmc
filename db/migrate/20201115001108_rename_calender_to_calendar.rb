class RenameCalenderToCalendar < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :google_calender_event_id, :google_calendar_event_id
    rename_column :organizations, :google_calender_id, :google_calendar_id
    rename_column :organizations, :google_calender_access_token, :google_calendar_access_token
    rename_column :organizations, :google_calender_expires_at, :google_calendar_expires_at
    rename_column :organizations, :google_calender_refresh_token, :google_calendar_refresh_token
  end
end
