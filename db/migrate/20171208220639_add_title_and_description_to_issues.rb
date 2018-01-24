class AddTitleAndDescriptionToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :title, :string, null: false
    add_column :issues, :description, :text
  end
end
