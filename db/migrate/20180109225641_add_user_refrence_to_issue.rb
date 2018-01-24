class AddUserRefrenceToIssue < ActiveRecord::Migration[5.1]
  def change
    add_reference :issues, :user
  end
end
