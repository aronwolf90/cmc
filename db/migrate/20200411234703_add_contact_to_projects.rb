class AddContactToProjects < ActiveRecord::Migration[5.1]
  def change
    add_reference :contacts, :project
  end
end
