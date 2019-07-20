# frozen_string_literal: true

class NotNullConstrainStartTime < ActiveRecord::Migration[5.1]
  def change
    Event.where(start_time: nil).delete_all
    change_column_null :events, :start_time, false
  end
end
