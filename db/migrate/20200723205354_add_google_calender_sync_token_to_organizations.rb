class AddGoogleCalenderSyncTokenToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :sync_token, :string
  end
end
