class AddUserAvatarToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :user_avatar
  end
end
