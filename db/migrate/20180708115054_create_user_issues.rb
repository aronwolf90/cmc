class CreateUserIssues < ActiveRecord::Migration[5.1]
  def change
    create_view :user_issues
  end
end
