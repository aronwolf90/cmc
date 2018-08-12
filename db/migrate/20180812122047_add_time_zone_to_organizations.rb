class AddTimeZoneToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :time_zone, :string
    Organization.update_all(time_zone: "Berlin")
    change_column :organizations, :time_zone, :string, null: :false
  end
end
