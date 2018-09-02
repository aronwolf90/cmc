class AddTimeZoneHoursToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :time_zone_seconds, :integer

    Organization.find_each do |organization|
      time_zone_seconds = Time.now.in_time_zone("Berlin").utc_offset
      organization.update!(time_zone_seconds: time_zone_seconds)
    end

    change_column_null :organizations, :time_zone_seconds, null: false
  end
end
