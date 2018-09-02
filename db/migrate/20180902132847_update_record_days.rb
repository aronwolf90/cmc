class UpdateRecordDays < ActiveRecord::Migration[5.1]
  def change
    update_view :record_days, version: 2, revert_to_version: 1
  end
end
