class AddGoogleCalenderRefreshToken < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :google_calender_refresh_token, :string
  end
end
