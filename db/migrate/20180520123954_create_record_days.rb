class CreateRecordDays < ActiveRecord::Migration[5.1]
  def change
    create_view :record_days
  end
end
