class AddTelephoneNumberToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :telephone_number, :string
  end
end
