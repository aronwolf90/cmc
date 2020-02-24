class AddIssueToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_reference :notifications, :issue
  end
end
