class AddComplexityToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :complexity, :decimal, precision: 2, scale: 1
  end
end
