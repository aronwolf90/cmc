class AddTimeZoneToOrganizations < ActiveRecord::Migration[5.1]
  def up
    add_column :organizations, :time_zone, :string
    Organization.update_all(time_zone: "Berlin")
    change_column_null :organizations, :time_zone, false
    change_column_null :organizations, :name, false
  end

  def down
    remove_column :organizations, :time_zone, :string
  end
end
