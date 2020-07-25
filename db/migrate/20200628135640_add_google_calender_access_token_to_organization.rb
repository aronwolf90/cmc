class AddGoogleCalenderAccessTokenToOrganization < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :google_calender_access_token, :string
  end
end
