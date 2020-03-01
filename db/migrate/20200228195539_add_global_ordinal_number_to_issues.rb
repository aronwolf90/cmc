class AddGlobalOrdinalNumberToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :global_ordinal_number, :integer
  end
end
