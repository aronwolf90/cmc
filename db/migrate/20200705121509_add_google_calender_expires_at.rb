class AddGoogleCalenderExpiresAt < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :google_calender_expires_at, :datetime
  end
end
