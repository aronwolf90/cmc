class CreateProjectRecordDays < ActiveRecord::Migration[5.1]
  def change
    create_view :project_record_days
  end
end
