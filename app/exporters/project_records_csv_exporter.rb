# frozen_string_literal: true

class ProjectRecordsCsvExporter < BaseCsvExporter
  include ApplicationHelper

  column :user
  column :description
  column :start_time
  column :end_time
  column :spended_time

  def spended_time(record)
    seconds_to_time(record.spended_time)
  end
end
