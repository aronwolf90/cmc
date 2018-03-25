class AddUniqueActiveRecordPerUserConstrain < ActiveRecord::Migration[5.1]
  def change
    add_index :records, :user_id, unique: true, where: "end_time IS NULL", name: :unique_active_record_per_user
  end
end
