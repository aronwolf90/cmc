class AddReadedToNotificationIfNotExist < ActiveRecord::Migration[5.1]
  def change
    !column_exists?(:notifications, :readed) &&
      add_column(:notifications, :readed, :boolean, default: false, null: false)
    !column_exists?(:notifications, :user_id) &&
      add_reference(:notifications, :user, null: false)
  end
end
