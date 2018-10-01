class IncreaseComplexityOfIssues < ActiveRecord::Migration[5.1]
  def change
    change_column :issues, :complexity,  :decimal, precision: 4, scale: 1
  end
end
