class AddTypeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :type, :string
    User.update_all(type: "Admin")
    change_column_null :users, :type, false
  end
end
